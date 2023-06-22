class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_join_table :conversations, :users, table_name: :matches do |t|
      t.index %i[conversation_id user_id]
    end
  end
end
