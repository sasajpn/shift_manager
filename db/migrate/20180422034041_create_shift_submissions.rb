class CreateShiftSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :shift_submissions do |t|
      t.references :member, foreign_key: true
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :status, defalut: 0, null: false

      t.timestamps
    end
  end
end
