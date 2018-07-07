class SessionsController < ApplicationController

  def new
    puts session[:access_token]
    puts session[:expires_at]
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
          flash.now.alert = "Email or password is invalid"
          render "new"
        end  
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    else
      @user = User.from_omniauth(request.env['omniauth.auth'].except('extra'))
      session[:user_id] = @user.id
      session[:access_token] = @user.oauth_token
      session[:expires_at] = @user.oauth_expires_at
      redirect_to blogs_path
    end  
  end
  def index
  end  

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    session[:expires_at] = nil
    redirect_to new_session_path
  end
end