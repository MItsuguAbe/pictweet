class CreateTweetTagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_tag_relations do |t|
      t.references :tweet, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
