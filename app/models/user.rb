class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # relationships
  has_many :stories
  has_one_attached :avatar
  has_many :comments
  has_many :follows, dependent: :destroy
  has_many :followings, through: :follows
  has_many :inverse_follows, foreign_key: "following_id", class_name: "Follow"
  has_many :followers, through: :inverse_follows, source: :user
  has_many :bookmarks


  # validations
  validates :username, presence: true, uniqueness: true
  validates :intro, length: { maximum: 250 }

  enum role: {
    user: 0,
    vip_user: 1,
    platinum_user: 2,
    admin: 3
  }

  # instance methods
  def paid_user?
    vip_user? or platinum_user?
  end
  
  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return 'Unbookmarked'
    else
      bookmarks.create(story: story)
      return 'Bookmarked'
    end
  end

  
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Followed'
    end
  end

  def follower_count
    self.followers.count = 0
  end
end
