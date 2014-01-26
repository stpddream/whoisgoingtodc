class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friender_id
      t.integer :friended_id

      t.timestamps
    end
    
    add_index :friends, :friender_id
    add_index :friends, :friended_id
    add_index :friends, [:friender_id, :friended_id], unique: true
    
    
  end
  

  
end
