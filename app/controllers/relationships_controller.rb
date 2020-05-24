class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)#この@userは現在ログインしているユーザー。ここでfollowメソッド呼び出す。
    if following.save
      redirect_to users_path
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to users_path
    end
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end
end

#set_userではいつものデータベース保存などの時のアップデートのパラムとは違い、
#userテーブルから1つのレコードを探してきている。pruvate以下に書きbefore_actionとしなくても、各アクションに記載してもよい。