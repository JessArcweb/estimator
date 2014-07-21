class AddNewsletterAndReportToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter, :boolean
    add_column :users, :report, :boolean
  end
end
