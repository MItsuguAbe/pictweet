class Tag < ApplicationRecord
  has_many :tweet_tag_relations, dependent: :delete_all 
  has_many :tweets, through: :tweet_tag_relations
end
