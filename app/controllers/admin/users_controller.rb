module Admin
  class UsersController < ApplicationController
    skip_before_action :authenticate_user, only: :select_user
    before_action :load_user, only: :batch_page
    before_action :load_batches, only: :batches
    before_action :load_batches_for_request, only: :batch_page

    def select_user
      @current_user = User.find_by(id: user_params[:user_id])
      session[:user_id] = @current_user.id

      redirect_to welcome_page_admin_users_path
    end

    def request_batch
      @current_user.request_batch(params[:batch_ids])
      redirect_to batches_admin_user_path
    end

    private

    def load_batches_for_request
      @batches = Batch.active.where.not(id: @current_user.active_batch_ids)
    end

    def load_batches
      @batches = @current_user.active_batch_users
    end

    def load_user
      @batches = Batch.active
    end

    def user_params
      params.permit(:user_id)
    end
  end
end
