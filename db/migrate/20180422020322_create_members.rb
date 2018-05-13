class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :role, null: false, default: 0
      t.string :calendar_color, null: false
      t.boolean :approve, null: false, default: false

      t.timestamps
    end
  end
end
