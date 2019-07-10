class CreateNewsArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :news_articles do |t|

      t.string :title
      t.text :description
      t.integer :view_count
      t.timestamp :published_at
      t.timestamp :created_at
      
    end
  end
end
