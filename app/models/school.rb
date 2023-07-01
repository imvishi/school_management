class School < ApplicationRecord
  # ----------------------------------------------------------------------------------------------------
  # ASSOCIATION
  # ----------------------------------------------------------------------------------------------------
  has_many :school_courses, dependent: :destroy
  has_many :enabled_school_courses, -> { enabled }, class_name: 'SchoolCourse', dependent: :destroy

  has_many :courses, through: :school_courses
  has_many :enabled_courses, through: :enabled_school_courses, source: :course

  has_many :school_users, dependent: :destroy
  has_many :enabled_school_users, -> { active }, class_name: 'SchoolUser', dependent: :destroy

  has_many :users, through: :school_users, source: :user
  has_many :enabled_users, through: :enabled_school_users, source: :user

  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  # --------------------------------------------------------------------------------------------------------
  # INSTANCE METHODS
  # --------------------------------------------------------------------------------------------------------
  def enabled_course_ids=(values)
    values.reject!(&:empty?)

    new_course_ids = values - enabled_course_ids.map(&:to_s)
    new_course_ids.each do |course_id|
      school_course = school_courses.find_or_initialize_by(course_id: course_id)
      school_course.enabled = true
      school_course.save
    end
    school_courses.where(course_id: values).update_all(enabled: true)
    school_courses.where.not(course_id: values).update_all(enabled: false)
  end

  def enabled_user_ids=(values)
    values.reject!(&:empty?)

    new_user_ids = values - enabled_user_ids.map(&:to_s)
    new_user_ids.each do |user_id|
      school_user = school_users.find_or_initialize_by(user_id: user_id)
      school_user.active = true
      school_user.save
    end
    school_users.where(user_id: values).update_all(active: true)
    school_users.where.not(user_id: values).update_all(active: false)
  end
end
