# Create Images Migration
class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :parent_id
      t.string :parent_type

      t.timestamps
    end
  end
end
