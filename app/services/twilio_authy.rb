require 'authy'
class TwilioAuthy

  attr_reader :user

  def initialize(user)
    @user = user
  end

# Return true if Authy Code is successfully updated
  def sign_up_authy

    if register_authy.ok?
      authy_id = register_authy.id
      update_authy(authy_id)
      return true if send_code_authy(authy_id)
    else
      @errors = register_authy.errors
      return @errors
    end      

  end  

# Generate Authy Code
  def register_authy

    Authy::API.register_user(
      email: @user.email,
      cellphone: @user.phone,
      country_code: @user.country_code,
    )

  end  

  # Update Authy Code

  def update_authy(authy_id)

    @user.update(authy_id: authy_id)

  end 

  # Send Authy Code to Authy app or Mobile
  def send_code_authy(authy_id)

    @authy_sms = Authy::API.request_sms(id: authy_id)

  end  

  # Verify Authy Code
  def verify_code_authy(authy_id, token)

    @authy_token = Authy::API.verify(id: authy_id, token: token)      
    return true if @authy_token.ok? 
  
  end 

end  
