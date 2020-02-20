
class Tweet < ApplicationRecord
    validates :text, presence: true

    belongs_to :user
    has_many :comments, dependent: :delete_all 

    has_many :tweet_tag_relations, dependent: :delete_all 
    has_many :tags, through: :tweet_tag_relations


    def self.search(search)
        return Tweet.all unless search
        Tweet.where('text LIKE(?)', "%#{search}%")
    end
end