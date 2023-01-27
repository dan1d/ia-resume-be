class ExperienceGeneratorJob < ApplicationJob
  queue_as :critical

  def perform(id)
    resume = Resume.find(id)

    resume.save_experience!
    ActionCable.server.broadcast "resumes:#{id}", {body: resume.as_json, event: 'updated'}
  end
end