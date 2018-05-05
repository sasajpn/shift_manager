class CreateLineRichmenus < ActiveRecord::Migration[5.0]
  def change
    create_table :line_richmenus do |t|
      t.string :type
      t.string :richmenu_id
      t.string :image

      t.timestamps
    end
    add_index :line_richmenus, :type
  end
end
