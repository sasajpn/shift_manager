class CreateShiftAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :shift_adjustments do |t|
      t.references :shift_submission, foreign_key: true
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.string :account_type
      t.integer :account_id

      t.timestamps
    end
  end
end
