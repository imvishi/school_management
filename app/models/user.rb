class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/.freeze
  # ----------------------------------------------------------------------------------------------------
  # ASSOCIATION
  # ----------------------------------------------------------------------------------------------------
  has_and_belongs_to_many :roles, join_table: 'user_roles'
  has_one :school_user, dependent: :destroy
  has_one :school, through: :school_user, source: :school

  has_many :batch_users, dependent: :destroy
  has_many :active_batch_users, -> { active }, class_name: 'BatchUser', dependent: :destroy

  has_many :batches, through: :batch_users, source: :batch
  has_many :active_batches, through: :active_batch_users, source: :batch
  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :name, :email, presence: true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: true

  # --------------------------------------------------------------------------------------------------------
  # SCOPE
  # --------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }

  def request_batch(values)
    values.reject!(&:empty?)

    values.each do |batch_id|
      batch_users << BatchUser.new(batch_id: batch_id, status: 1)
    end
  end

  def admin?
    roles.where(name: "Admin").any?
  end

  def school_admin?(school)
    return true if admin?

    return false unless roles.where(name: "SchoolAdmin").any?

    school_user.school_id == school.id && school_user.active
  end
end
