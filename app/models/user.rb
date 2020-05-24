class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#  has_many :books, dependent: :destroy
  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'user_id'
  has_many :followings, through: :relationships, source: :follow #throughを使ってRelationshipのfollow_idと結合する。何と結合するかは後で指定。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user #userテーブルから自分をフォローしているuserを取得
  attachment :profile_image
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  def follow(other_user)
    unless self == other_user #フォローしようとしているother_userが自分自身ではないかを検証
      self.relationships.find_or_create_by(follow_id: other_user.id)
      #Relationship.find_or_create_by(user_id: self.id, follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)#呼び出し元(current_user)のfollowingsという配列に引数が含まれているかどいう情報
  end

end

#current_user = User.find 1

#user = User.find 2

#current_user.following?(user)

#[1,2,3,5].include?(10)
#true

#user.books