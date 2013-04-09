class AddExciteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :excite, :string
  end
end
