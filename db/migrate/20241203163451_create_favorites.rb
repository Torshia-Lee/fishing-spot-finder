class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lake, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end