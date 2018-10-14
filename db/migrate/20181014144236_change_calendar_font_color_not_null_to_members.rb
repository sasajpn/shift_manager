class ChangeCalendarFontColorNotNullToMembers < ActiveRecord::Migration[5.0]
  def up
    change_column_null :members, :calendar_font_color, true
  end

  def down
    change_column_null :members, :calendar_font_color, false
  end
end
