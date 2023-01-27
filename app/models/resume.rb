class Resume < ApplicationRecord
  validates :full_name, :job_title, :skills, :experience, presence: true

  after_create :extract_data

  def save_skills!
    result = service.get_resume_skills
    update_attribute(:ia_skills, result)
  end

  def save_short_description!
    result = service.get_resume_short
    update_attribute(:ia_description, result)
  end

  def save_experience!
    result = service.get_experience
    update_attribute(:ia_experience, result)
  end

  private

  def extract_data
    SkillsGeneratorJob.perform_later(self.id)
    ResumeIntroGeneratorJob.perform_later(self.id)
    ExperienceGeneratorJob.perform_later(self.id)
  end

  def service
    @service = BotService.new(resume: self)
  end
end
