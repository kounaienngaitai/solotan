class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.admin_id = ""
    if @post.save
      redirect_to post_path(@post), notice: "ソロ活情報が投稿出来ました！"
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(5)
      @counts = @posts.total_count
    elsif params[:keyword]
      @posts = Post.search(params[:keyword]).page(params[:page]).per(10)
      @counts = @posts.total_count
    else
      @posts = Post.published.page(params[:page]).per(10)
      @counts = Post.count
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to users_mypage_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path, notice: "ソロ活情報が更新されました。"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "ソロ活情報が削除されました。"
  end

  def confirm
    @posts = Post.where(status: ['draft', 'unpublished']).where(user_id: current_user.id).page(params[:page]).per(10)
  end

  private

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
                                 :status,
                                 :tag_list,
                                 :star)
  end
end
