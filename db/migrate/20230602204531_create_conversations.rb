class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations, primary_key: 'conversation_id' do |t|
      t.string :topic_icon
      t.string :last_message
      t.integer :unread_messages, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
