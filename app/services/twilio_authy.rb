  require 'authy'
  class TwilioAuthy

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def sign_up_authy

      if register_authy.ok?
        puts "In"
        puts register_authy.id
        authy_id = register_authy.id
        update_authy(authy_id)
        return true if send_code_authy(authy_id)
      else
        @errors = register_authy.errors
        return @errors
      end      

    end  

    def register_authy

      Authy::API.register_user(
        email: @user.email,
        cellphone: @user.phone,
        country_code: @user.country_code,
      )

    end  

    def update_authy(authy_id)

      @user.update(authy_id: authy_id)

    end 

    def send_code_authy(authy_id)

      @authy_sms = Authy::API.request_sms(id: authy_id)

    end  

    def verify_code_authy(authy_id, token)

      @authy_token = Authy::API.verify(id: authy_id, token: token)      
      return true if @authy_token.ok? 
    
    end 

  end  
