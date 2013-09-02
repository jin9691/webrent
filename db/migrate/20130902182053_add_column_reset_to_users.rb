class AddColumnResetToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:reset,:boolean,default: true
  	add_column :users,:send_reset_at,:datetime
  end
end
