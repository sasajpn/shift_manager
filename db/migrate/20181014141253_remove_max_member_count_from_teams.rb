class RemoveMaxMemberCountFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :max_member_count, :integer
  end
end
