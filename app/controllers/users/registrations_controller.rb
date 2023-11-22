# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def index
  end

  def new
    @family_user = FamilyUser.new
  end

  def create
    @family_user = FamilyUser.new(family_params)
      unless @family_user.valid?

        session[:family_user_errors] = @family_user.errors.full_messages
        render :new, status: :unprocessable_entity and return
      end
    session["family.regist_data"] = { family: family_params }
    render template: 'devise/registrations/new_user', status: :accepted
  end

  def new_user
    family_user_params = session["family.regist_data"]["family"]
    @family_user = FamilyUser.new(family_user_params[:family])  
  end
    

  def create_user
    family_user_params = session["family.regist_data"]["family"]
    family_user_params["user2"] = user2_params.to_h
    @family_user = FamilyUser.new(family_user_params)


    @user1 = User.new(session["family.regist_data"]["family"]["user1"])
    @user2 = User.new(user2_params)
    @family = Family.new(name: session["family.regist_data"]["family"]["name"])

    unless @family_user.valid?
      render :new_user, status: :unprocessable_entity and return
    end

    if @family.save
      @user1.family = @user2.family = @family

      unless @user1.save && @user2.save
        @family_user.errors.add(:base, "２人のユーザーを登録してください")
        render :new_user, status: :unprocessable_entity and return
      end

      session["family.regist_data"]["family"].clear
      sign_in(:user, @user1)

      redirect_to root_path
    else
      @family_user.errors.add(:base, "この家族名は既に存在しています")
      render :new_user, status: :unprocessable_entity and return
    end    
  end
      

  private

  def family_params
    params.require(:family_user).permit(:name, user1: [:nickname, :email, :password, :password_confirmation])
  end



  def user2_params
    params.require(:family_user).require(:user2).permit([:nickname, :email, :password, :password_confirmation])
  end


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
