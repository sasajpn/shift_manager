class AddStripeColumnsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :stripe_plan_id, :string
    add_column :teams, :stripe_card_id, :string
    add_column :teams, :stripe_customer_id, :string
    add_column :teams, :stripe_subscription_id, :string
  end
end
