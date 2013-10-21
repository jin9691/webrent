class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.integer :type_id
      t.integer :user_id
      t.string :name
      t.integer :view
      t.datetime :expired
      t.boolean :active

      t.timestamps
    end
  end
end
