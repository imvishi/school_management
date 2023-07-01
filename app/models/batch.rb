class Batch < ApplicationRecord
  attr_accessor :course_id

  # ----------------------------------------------------------------------------------------------------
  # ASSOCIATION
  # ----------------------------------------------------------------------------------------------------
  belongs_to :school_course

  has_many :batch_users, dependent: :destroy
  has_many :active_batch_users, -> { active }, class_name: 'BatchUser', dependent: :destroy

  has_many :users, through: :batch_users, source: :user
  has_many :active_users, through: :active_batch_users, source: :user
  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :name, presence: true

  # --------------------------------------------------------------------------------------------------------
  # SCOPE
  # --------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }

  def update_school_course(school)
    self.school_course_id = school.school_courses.find_by(course_id: course_id).id
  end

  def active_user_ids=(values)
    values.reject!(&:empty?)

    new_user_ids = values - active_user_ids.map(&:to_s)
    new_user_ids.each do |user_id|
      batch_user = batch_users.find_or_initialize_by(user_id: user_id)
      batch_user.active = true
      batch_user.save
    end
    batch_users.where(user_id: values).update_all(active: true)
    batch_users.where.not(user_id: values).update_all(active: false)
  end
end
