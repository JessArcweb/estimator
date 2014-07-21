class AddEstimateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :estimate, :string
  end
end
