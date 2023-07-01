class SchoolUser < ApplicationRecord

  # ----------------------------------------------------------------------------------------------------
  # ASSOCIATION
  # ----------------------------------------------------------------------------------------------------
  belongs_to :school, optional: false
  belongs_to :user, optional: false

  # --------------------------------------------------------------------------------------------------------
  # SCOPE
  # --------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }
end
