class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.float :radius, null: false
      t.float :lat, null: false
      t.float :lng, null: false
      t.references :user, foreign_key: true, null: false
      t.references :topic, foreign_key: true, null: false

      t.timestamps
      t.check_constraint('radius > 0', name: 'radius_positive')
    end
  end
end
