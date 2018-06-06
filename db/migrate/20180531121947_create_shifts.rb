class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.references :member, foreign_key: true
      t.references :shift_submission, foreign_key: true
      t.date :registered_date
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.string :type, null: false
      t.string :account_type
      t.integer :account_id

      t.timestamps
    end
    add_index :shifts, :type
  end
end
