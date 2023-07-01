class CreateSchoolCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :school_courses do |t|
      t.references :school, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.boolean :enabled, default: true, null: false, index: true

      t.timestamps
    end
  end
end
