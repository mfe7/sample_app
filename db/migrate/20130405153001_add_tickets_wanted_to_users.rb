class AddTicketsWantedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tickets_wanted, :integer, default: 0
  end
end
