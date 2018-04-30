class CreateLineConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :line_connections do |t|
      t.string :account_type
      t.integer :account_id
      t.string :nonce

      t.timestamps
    end
  end
end
