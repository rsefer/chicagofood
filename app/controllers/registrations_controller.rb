class RegistrationsController < Devise::RegistrationsController
	prepend_before_action :check_captcha, only: [:create]

	def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank?
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated

      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

  def resource_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :avatar, :street, :city, :state)
  end

  private :resource_params

  private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end

end
