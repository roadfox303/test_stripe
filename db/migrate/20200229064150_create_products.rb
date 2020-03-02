class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.string :currency, null:false
      t.integer :amount, null:false
      t.string :description, null:false
      t.timestamps
    end
  end
end
