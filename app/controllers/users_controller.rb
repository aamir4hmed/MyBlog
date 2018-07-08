class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # # GET /users/1
  # # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
        
    if @user.save
      # Use service class to generate Authy code and send it via app or sms
      @authy_signup = TwilioAuthy.new(@user).sign_up_authy
      if @authy_signup
        session[:pre_auth_user_id] = @user.id
        redirect_to user_send_code_path(id: session[:pre_auth_user_id], access_token: session[:access_token])
      else
        flash[:notice] = "Authy Registration Failed. Please try again"
        redirect_to new_user_path
      end
    else
      flash[:notice] = "Incorrect User Credentials"
      render :new
    end

  end

  def send_code
    @user = User.find_by(id: session[:pre_auth_user_id])
    puts 
  end  

  def verify
    @user = User.find_by(id: session[:pre_auth_user_id])
    
    @authy_signup = TwilioAuthy.new(@user).verify_code_authy(@user.authy_id, params[:token] )
    if @authy_signup
      # Mark the user as verified for get /user/:id
      @user.update(verified: true)
      oauth_token = OauthToken.new(@user).check_token      
      if oauth_token
        session[:user_id] = @user.id
        session[:access_token] = @user.oauth_token  
        redirect_to root_path(access_token: session[:access_token]) 
      else
        redirect_to new_user_path
      end  
    else
      flash.now[:danger] = "Incorrect code, please try again"
      redirect_to user_send_code_path(id: session[:pre_auth_user_id], access_token: session[:access_token])
    end
  end

  def resend
    @user = User.find_by(id: session[:pre_auth_user_id])
    # Authy::API.request_sms(id: @user.authy_id)
    TwilioAuthy.new(@user).send_code_authy(@user.authy_id)
    flash[:notice] = 'Verification code re-sent'
    redirect_to user_verify_path(id: @user.id)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:email, :country_code, :phone, :password, :password_confirmation, :provider )
    end
end
