class CreateWebTypes < ActiveRecord::Migration
  def change
    create_table :web_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
