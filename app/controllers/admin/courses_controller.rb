module Admin
  class CoursesController < ApplicationController
    before_action :validate_admin
    before_action :load_courses, only: :index
    before_action :load_course, only: [:edit, :update]

    def new
      @resource = Course.new
    end

    def create
      @resource = Course.new(course_params)

      respond_to do |format|
        if @resource.save
          format.html { redirect_to admin_course_url(@resource), notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.update(course_params)
          format.html { redirect_to admin_course_url(@resource), notice: "Course was successfully updated." }
          format.json { render :show, status: :ok, location: @resource }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def load_courses
      @collection = Course.all
    end

    def load_course
      @resource = Course.find_by_id(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :slug, :active)
    end
  end
end
