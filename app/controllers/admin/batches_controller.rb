module Admin
  class BatchesController < ApplicationController
    before_action :load_school
    before_action :validate_school_admin
    before_action :load_courses, only: [:edit, :new]
    before_action :load_batches, only: :index
    before_action :load_batch, only: [:edit, :update]

    def new
      @resource = Batch.new
    end

    def create
      @resource = Batch.new(batch_params)
      @resource.update_school_course(@school)

      respond_to do |format|
        if @resource.save
          format.html { redirect_to admin_school_batches_path(@school), notice: 'Batch was successfully created.' }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.update(batch_params)
          format.html { redirect_to admin_school_batches_path(@school), notice: 'Batch was successfully updated.' }
          format.json { render :show, status: :ok, location: @resource }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def validate_school_admin
      return if @current_user.school_admin?(@resource)

      flash[:notice] = 'Unauthorize user'
      redirect_to welcome_page_admin_users_path
    end

    def load_school
      @school = School.find_by_id(params[:school_id])
    end

    def load_courses
      @courses = Course.joins(:school_courses).where(school_courses: { enabled: true, school_id: params[:school_id] })
    end

    def load_batches
      @collection = Batch.joins(school_course: :course).where(school_course: { school_id: params[:school_id] })
    end

    def load_batch
      @resource = Batch.find_by_id(params[:id])
    end

    def batch_params
      params.require(:batch).permit(:name, :slug, :active, :course_id, { active_user_ids: [] })
    end
  end
end
