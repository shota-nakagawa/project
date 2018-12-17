class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes([:favorite_users, :comment_users])
  end

  def show
    @topics = Topic.all.includes([:favorite_users, :comment_users])
    @favorites_count = Favorite.where(topic_id: topic.id).count
    #@topic = Topic.find(params[:id])
  end

  def edit
   @topic = Topic.find_by(user_id: params[:user_id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

  if @topic.save
    redirect_to topics_path, success: '投稿に成功しました'
  else
    flash.now[:danger] = "投稿に失敗しました"
    render :new
  end
end

 def comment
   @comment = Comment.new(comment: params[:comment], topic_id: params[:topic_id], user_id: params[:user_id])
   @comment.save
   redirect_to topics_path
 end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
