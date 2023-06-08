class Pets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
    t.string :name
     t.integer :pet_id
     t.string :breed
     t.string :image_url
     t.timestamps 
    end
  end
end
