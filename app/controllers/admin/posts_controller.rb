class Admin::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = current_admin.posts
  end

  def create
    @post = Post.new(post_params)
    @post.admin_id = current_admin.id
    @post.user_id = ""
    if @post.save!
      redirect_to admin_post_path(@post), notice: "ソロ活情報が投稿出来ました！"
    else
      flash[:notice] = "投稿に失敗しました。"
      render :index
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path, notice: "ソロ活情報が更新されました。"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: "ソロ活情報が削除されました。"
  end

  def post_params
    params.require(:post).permit(:title,
                                 :facility,
                                 :point,
                                 :postal_code,
                                 :address,
                                 :nearest_station,
                                 :access,
                                 :telephone_number,
                                 :open,
                                 :average_price,
                                 :closed,
                                 :detail_url,
                                 :note,
                                 :post_image,
                                 :user_id,
                                 :admin_id,
                                 :star)
  end
end
