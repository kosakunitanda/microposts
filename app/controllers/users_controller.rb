class UsersController < ApplicationController
  def followings
    @title = "followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    @users = User.page(params[:page])
    
  end


  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    @users = User.page(params[:page])
    render 'followings'
  end


  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end

    
  end
  

  def create
    
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :age , :profile_name ,:area)
  end
 
end

