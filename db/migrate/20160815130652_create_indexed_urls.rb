class CreateIndexedUrls < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    create_table :indexed_urls do |t|
      t.string :url, null: false
      t.string :status, null: false
      t.hstore :content, default: {}, null: false

      t.timestamps
    end
  end
end
