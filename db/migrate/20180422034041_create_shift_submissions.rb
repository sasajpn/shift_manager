class CreateShiftSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :shift_submissions do |t|
      t.references :member, foreign_key: true
      t.date :submitted_date, null: false
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
