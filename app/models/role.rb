class Role < ApplicationRecord
  # ----------------------------------------------------------------------------------------------------
  # ASSOCIATION
  # ----------------------------------------------------------------------------------------------------
  has_and_belongs_to_many :users, join_table: 'user_roles'

  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
