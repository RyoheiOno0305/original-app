class User < ApplicationRecord
	before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :intro, length: {maximum: 500}
	has_secure_password
	
	has_many :posts
	has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :favs, through: :favorites, source: :post
  has_many :ownerships
  has_many :items, through: :ownerships
  has_many :wants
  has_many :want_items, through: :wants , class_name:'Item', source: :item
  has_many :has, class_name: 'Have'
  has_many :have_items, through: :has, class_name: 'Item', source: :item

  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(user_id)
    self.followings.include?(user_id)
  end
  
  def fav(post_id)
      self.favorites.find_or_create_by(post_id: post.id)
  end

  def unfav(post_id)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  def faving?(post_id)
    self.favs.include?(post_id)
  end
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end
  
  def have(item)
    self.has.find_or_create_by(item_id: item.id)
  end

  def unhave(item)
    have = self.has.find_by(item_id: item.id)
    have.destroy if have
  end

  def have?(item)
    self.have_items.include?(item)
  end
end
