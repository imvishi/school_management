# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Roles
admin_role = Role.create(name: 'Admin')
school_admin_role = Role.create(name: 'SchoolAdmin')
student_role = Role.create(name: 'Student')

# Create admin User
admin = User.create(name: 'admin', email: 'admin@management.com', password: 'Test@1212')
admin.roles << admin_role
admin.save

# Create school Admin
school_admin = User.create(name: 'school admin', email: 'student_admin@management.com', password: 'Test@1212')
school_admin.roles << school_admin_role
school_admin.save

# Create school Admin
school_admin2 = User.create(name: 'school admin2', email: 'student_admin2@management.com', password: 'Test@1212')
school_admin2.roles << school_admin_role
school_admin2.save

# Create student
student = User.create(name: 'student1', email: 'student1@management.com', password: 'Test@1212')
student.roles << student_role
student.save

# Create student
student = User.create(name: 'student2', email: 'student2@management.com', password: 'Test@1212')
student.roles << student_role
student.save

# Create student
student = User.create(name: 'student3', email: 'student3@management.com', password: 'Test@1212')
student.roles << student_role
student.save

# Create student
student = User.create(name: 'student4', email: 'student4@management.com', password: 'Test@1212')
student.roles << student_role
student.save

# Create student
student = User.create(name: 'student5', email: 'student5@management.com', password: 'Test@1212')
student.roles << student_role
student.save
