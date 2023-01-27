class ResumeIntroGeneratorJob < ApplicationJob
  queue_as :critical

  def perform(id)
    resume = Resume.find(id)

    resume.save_short_description!
    ActionCable.server.broadcast "resumes:#{id}", {body: resume.as_json, event: 'updated'}
  end
end