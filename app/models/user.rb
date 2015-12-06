class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :profile_name, presence: true, length: { maximum: 100 }, on: :update
  validates :area, presence: true, length: { maximum: 50 }, on: :update
  validates :age, numericality: { only_integer: true , greater_than_or_equal_to: 0 , less_than_or_equal_to: 200 } , presence: true, on: :update 

  has_secure_password

  has_many :microposts
  
  
   
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  #following_relationshipsのforeign_keyのfollower_idにuserのidが入るので、user.following_relationshipsによって、
  #userがフォローしている場合のRelationshipを取得することができます。
  
  #following_usersでは、has_many 〜 throughという文を使っています。throughには、following_relationshipsが指定されていて、
  #following_relationshipsを経由してデータを取得することを意味しています。
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  
  #userがフォローしている人は、following_relationshipsのfollowed_idに一致するユーザーになるので、sourceとしてfollowedを指定しています。
  has_many :following_users, through: :following_relationships, source: :followed
  
  

  #follower_relationshipsのforeign_keyのfollowed_idにuserのidが入るので、user.follower_relationshipsによって、userがフォローされている場合のRelationshipを取得することができます。
  #follower_usersの、has_many 〜 throughのthroughには、follower_relationshipsが指定されていて、上の図のように、follower_relationshipsを経由してデータを取得することを意味しています。
  #userをフォローしている人は、follower_relationshipsのfollower_idに一致するユーザーになるので、sourceとしてfollowerを指定しています。
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  paginates_per 2  # 1ページあたり2項目表示

  
end
