class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :send_code, :verify_code, :resend]
  before_action :authorize, except: [:index]

  def authorize
    # Use doorkeeper oauth when the provider is not facebook or google
    unless current_user.provider == "facebook" || current_user.provider == "google_oauth2"
      doorkeeper_authorize!
    end 
  end  

  def index
    # List only published Blogs
    @blogs = Blog.published

  end

  def my_blog_list
    # List only the current users blogs
    @blogs = Blog.where(user_id: current_user)

  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @user = current_user
    # Use service class to generate Authy code and send it via app or sms
    send_token = TwilioAuthy.new(@user).send_code_authy(@user.authy_id)
    respond_to do |format|
      if @blog.save
        flash[:notice] = 'Blog has been saved as Drafts'
        format.js  { render :send_code, locals: {blog_id: @blog.id} }
      else
        format.js { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

# Method to send Authy code after editing blog
  def send_code
    @user = current_user
    # Use service class to generate Authy code and send it via app or sms
    send_token = TwilioAuthy.new(@user).send_code_authy(@user.authy_id)
    respond_to do |format|
      format.js  { render :send_code, locals: {blog_id: @blog.id} }
    end
  end

# Method to verify code after adding/editing blog
  def verify_code
    @user = current_user
     # Use service class to verify Authy code
    @authy_signup = TwilioAuthy.new(@user).verify_code_authy(@user.authy_id, params[:token] )
    if @authy_signup
      @blog.update(verify: true)
      # Publish the blog when after 2FA
      @blog.update(article_status: "Published")
      flash[:notice] = 'Article has been published'
    else
      flash.now[:danger] = "Incorrect code, please try again"
      render :send_code, locals: {blog_id: @blog.id}
    end
  end

# Method to resend verification code after adding/editing blog
  def resend
    @user = current_user
      # Use service class to resend Authy code
    TwilioAuthy.new(@user).send_code_authy(@user.authy_id)
    flash[:notice] = 'Verification code re-sent'
    render :send_code, locals: {blog_id: @blog.id}
  end  

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.js { render :show, locals: {blog_id: @blog.id, access_token: session[:access_token]} , notice: 'Blog was successfully updated.' }
        flash[:notice] = 'Article has been updated'
      else
        flash[:notice] = 'Article has not been updated'
        format.js { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url(access_token: session[:access_token]), notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:user_id, :title, :description, :content, :article_status, :verify)
    end
end
