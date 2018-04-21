class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :owner, foreign_key: true
      t.string :name
      t.string :identifier

      t.timestamps
    end
  end
end
