class SkillsGenerator < ApplicationJob
  queue_as :critical

  def perform(id)
    resume = Resume.find(id)

    resume.save_skills!
  end
end