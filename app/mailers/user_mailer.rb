class UserMailer < ApplicationMailer
  
  def account_activation
    @greeting = "Hi"
    mail to: "to@example.org"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account activation'
  end

end
