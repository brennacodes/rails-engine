class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.varchar :name
      t.varchar :description
      t.double :unit_price
      t.string :precision
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
