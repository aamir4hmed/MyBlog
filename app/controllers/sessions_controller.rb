class SessionsController < ApplicationController

  def new
  end
    
  def create
    if params[:provider] == "NewBlog"
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        oauth_token = OauthToken.new(@user).check_token
        if oauth_token
          session[:user_id] = @user.id
          session[:access_token] = @user.oauth_token
          redirect_to blogs_path(access_token: session[:access_token]) 
        else
          flash[:notice] = "Invalid Authy credentials"
          render "new"
        end  
      else
        flash[:notice] = "Email or password is invalid"
        render "new"
      end
    else
      @user = User.from_omniauth(request.env['omniauth.auth'].except('extra'))
      session[:user_id] = @user.id
      session[:access_token] = @user.oauth_token
      redirect_to blogs_path
    end  
  end
  def index
  end  

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to new_session_path
  end
end