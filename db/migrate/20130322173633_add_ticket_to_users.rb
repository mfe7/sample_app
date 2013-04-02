class AddTicketToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tickets_purchased, :integer, default: 0
  end
end
