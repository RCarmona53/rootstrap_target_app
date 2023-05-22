class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false, unique: true

      t.timestamps null: false
    end

    add_index :topics, :name, unique: true
  end
end
