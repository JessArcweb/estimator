class AddAnswersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :answers, :string, array: true, default: []
  end
end
