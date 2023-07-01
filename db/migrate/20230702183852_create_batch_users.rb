class CreateBatchUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :batch_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :batch, null: false, foreign_key: true
      t.boolean :active, null: false, default: true, index: true
      t.integer :status, null: false, default: 0, index: true
      t.timestamps
    end
  end
end
