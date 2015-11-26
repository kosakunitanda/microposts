
class RelationshipsController < ApplicationController

  before_action :logged_in_user

  def create
    #createメソッドでは、フォローする他のユーザーのIDをパラメータとして受け取り、
    #見つかったユーザーを引数としてUserモデルのfollowメソッドを実行します。
    
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    #destroyメソッドは、現在のユーザーのfollowing_relationshipsを検索して他のユーザーをフォローしている場合は、
    #そのユーザーを引数としてUserのunfollowメソッドを実行します。

    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
