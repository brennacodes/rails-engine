class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.varchar :first_name
      t.varchar :last_name

      t.timestamps
    end
  end
end
