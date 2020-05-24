class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'#followモデルなんて存在しないので、userモデルにbelongs_toしてね！という意味。

  validates :user_id, presence: true #フォローする人の
  validates :follow_id, presence: true
end
