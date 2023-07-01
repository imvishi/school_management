class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: true
      t.string :password
      t.boolean :active, index: true, null: false, default: true
      t.timestamps
    end
  end
end
