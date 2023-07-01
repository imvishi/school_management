module Authenticatable
  extend ActiveSupport::Concern

  included do
    prepend_before_action :authenticate_user_via_jwt

    def authenticate_user_via_jwt
    end
  end
end