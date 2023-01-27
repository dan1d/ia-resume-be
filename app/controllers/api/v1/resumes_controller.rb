class Api::V1::ResumesController < ApplicationController

  def index
    resources = Resume.limit(10).last
    render json: resources
  end

  def show
    resource = Resume.find(params[:id])
    render json: resource
  end

  def create
    resource = Resume.new(permited_params)
    if resource.save
      render json: resource
    else 
      head 403
    end
  end

  private

  def permited_params
    params.require(:resume).permit([:skills, :full_name, :job_title, :experience])
  end
end