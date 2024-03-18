class Public::UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path, notice: "会員情報が更新されました。"
    else
      flash[:notice] = "更新のお手続きが出来ませんでした。"
      render :edit
    end
  end

  def confirm
  end

  def withdrawal
    @user = current_user
    @user.update(status: 2)
    reset_session
    redirect_to top_path, notice: "退会のお手続きが完了しました。"
  end

  private

  def user_params
    params.require(:user).permit(:last_name,
                                 :first_name,
                                 :last_name_kana,
                                 :first_name_kana,
                                 :handle_name,
                                 :email,
                                 :postal_code,
                                 :address,
                                 :telephone_number,
                                 :profile_image)
  end

end
