class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.text :contents
      t.string :skintype
      t.string :age
      t.boolean :atopy
      t.boolean :pimple
      t.boolean :allergy
      t.boolean :bb
      t.boolean :lip
      t.boolean :eyebrow
      t.boolean :eyeline
      t.boolean :color
      t.integer :skincolor

      t.timestamps
    end
  end
end
