module Admin
  class SchoolsController < ApplicationController
    before_action :validate_admin, only: [:index, :new, :create]
    before_action :load_schools, only: :index
    before_action :load_school, only: [:edit, :update]
    before_action :validate_school_admin, only: [:edit, :update]

    def new
      @resource = School.new
    end

    def create
      @resource = School.new(school_params)

      respond_to do |format|
        if @resource.save
          format.html { redirect_to admin_school_url(@resource), notice: 'School was successfully created.' }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.update(school_params)
          format.html { redirect_to admin_school_url(@resource), notice: "School was successfully updated." }
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

    def load_schools
      @collection = School.all
    end

    def load_school
      @resource = School.find_by_id(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :slug, :active, { enabled_course_ids: [] }, { enabled_user_ids: [] })
    end
  end
end
