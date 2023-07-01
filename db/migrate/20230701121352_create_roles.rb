class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :active, index: true, null: false, default: true

      t.timestamps
    end
  end
end
