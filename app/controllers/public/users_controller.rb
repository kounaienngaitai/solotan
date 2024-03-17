class Public::UsersController < ApplicationController


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
      render :edit
    end
  end

  def confirm
  end

  def withdrawal
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
                                 :telephone_number)
  end

end
