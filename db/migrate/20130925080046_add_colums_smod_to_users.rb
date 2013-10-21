class AddColumsSmodToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :smod, :boolean, default: false
  end
end
