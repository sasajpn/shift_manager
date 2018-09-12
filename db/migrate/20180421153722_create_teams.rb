class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :owner, foreign_key: true
      t.string :name
      t.string :identifier
      t.string :open_time, null: false
      t.string :close_time, null: false
      t.boolean :all_day, default: false, null: false
      t.datetime :active_until, null: false
      t.integer :max_member_count, null: false, default: 0

      t.timestamps
    end
  end
end
