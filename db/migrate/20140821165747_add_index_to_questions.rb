class AddIndexToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :index, :integer
  end
end
