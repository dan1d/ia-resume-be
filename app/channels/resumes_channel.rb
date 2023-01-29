class ResumesChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "resumes:#{params[:resume_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
