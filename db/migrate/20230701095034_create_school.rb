class CreateSchool < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false, index: true
      t.boolean :active, null: false, index: true, default: true
      t.string :slug, null: false, index: true

      t.timestamps
    end
  end
end
