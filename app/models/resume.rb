class Resume < ApplicationRecord
  validates :full_name, :job_title, :skills, :experience, presence: true

  after_create :extract_data

  def save_skills!
    result = service.get_resume_skills
    result.update_attribute(:ia_skills, result)
  end

  def save_short_description!
    result = service.get_resume_short
    result.update_attribute(:ia_description, result)
  end

  def save_experience!
    result = service.get_experience
    update_attribute(:ia_experience, result)
  end

  private

  def extract_data
    ResumeGenerator.new(self.id).perform_now
  end

  def service
    @service = BotService.new(resume: resume)
  end
end
