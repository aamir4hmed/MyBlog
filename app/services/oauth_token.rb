class OauthToken

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def check_token    
    user_application = @user.application
    if user_application.blank?
      user_application = Doorkeeper::Application.create!(name: "NewBlog", redirect_uri: ENV["oauth_redirect_uri"] )
    end
    if @user.access_tokens.blank?
      access_token = @user.access_tokens.create!(resource_owner_id: @user.id, application_id: user_application.id, expires_in: Time.now + 30.minutes)  
      @user.update(uid: user_application.uid,oauth_token: access_token.token,oauth_expires_at: Time.at(access_token.expires_at))        
    end 
    return true if @user.oauth_token
  end     
end  
