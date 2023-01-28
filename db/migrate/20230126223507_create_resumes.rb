class CreateResumes < ActiveRecord::Migration[7.0]
  def change
    create_table :resumes do |t|
      t.string :full_name, null: false
      t.string :skills, null: false
      t.string :experience, null: false
      t.string :job_title, null: false

      t.text :ia_description
      t.text :ia_experience
      t.text :ia_skills

      t.text :final_description
      t.text :final_experience
      t.text :final_skills
      t.text :contact_email

      t.timestamps
    end
  end
end
