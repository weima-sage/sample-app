class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by_email params[:email]
    has_error = true
    
    if !user
      flash[:danger] = 'Could not find user'
    elsif user.activated? 
      flash[:danger] = 'User are already activated'
    elsif !user.authenticated?(:activation, params[:id])
      flash[:danger] = 'User are not authenticated'
    else
      user.activate
      log_in user
      flash[:success] = 'Account activated!'
      has_error = false
    end

    redirect_to has_error ? root_url : user
  end
end
