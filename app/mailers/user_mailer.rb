class UserMailer < ApplicationMailer
  
  def account_activation
    @greeting = "Hi"
    mail to: "to@example.org"
  end

  def password_reset(user)
    update_user_and_send_mail user, 'Password reset'
  end

  def account_activation(user)
    update_user_and_send_mail user, 'Account activation'
  end

  private 
    def update_user_and_send_mail(user, subject)
      @user = user
      mail to: user.email, subject: subject
    end

end
