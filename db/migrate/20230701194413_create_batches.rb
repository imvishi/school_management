class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.string :name, null: false, index: true
      t.boolean :active, null: false, index: true, default: true
      t.references :school_course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
