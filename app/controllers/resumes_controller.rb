class ResumesController < ApplicationController

  def index
    resources = Resume.limit(10).last
    respond_to do |format|
      format.json { render json: resources }
    end
  end

  def create
    resource = Resume.new(permited_params)
    if resource.save
      respond_to do |format|
        format.json { render json: resource }      
      end
    else 
      head 403
    end
  end

  private

  def permited_params
    params.require(:resume).permit([:skills, :full_name, :job_title, :experience])
  end
end