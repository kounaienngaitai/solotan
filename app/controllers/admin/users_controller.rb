class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました。"
    else
      flash.now[:notice] = "更新のお手続きが出来ませんでした。"
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:last_name,
                                 :first_name,
                                 :last_name_kana,
                                 :first_name_kana,
                                 :handle_name,
                                 :email,
                                 :birth_date,
                                 :postal_code,
                                 :address,
                                 :telephone_number,
                                 :status,
                                 :profile_image)
  end

end
