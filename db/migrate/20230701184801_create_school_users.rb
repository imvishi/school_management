class CreateSchoolUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :school_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.boolean :active, null: false, default: true, index: true
      t.timestamps
    end
  end
end
