class BotService
  attr_reader  :client, :resume

  delegat :full_name, :job_title, :skills, :experience, to: :resume

  def initialize(resume:)
    @client = ::OpenAI::Client.new(access_token: Rails.env.CHAT_GPT )
  end

  def get_resume_short
    is_valid = "does the following inputs they look like a job title and skills for that job? answer yes or no, job title: #{job_title} skills #{skills.to_sentence}"
    if is_yes?(is_valid)
      prompt = "Write an intro for my resume as #{job_title} having in mind my background on skills: #{skills.to_sentence}"
      result = make_request(prompt)
      
      puts "result: #{result}"

      result
    else 
      raise "Not valid"
    end
  end

  def get_resume_skills
    prompt = "write a short list of skills related to my job as #{job_title} having this skills on mind: #{skills.to_sentence}"
    result = make_request(prompt)
    
    puts "result: #{result}"

    result
  end

  def get_experience
    is_valid = "the given input surrounded by curly braces {#{experience.to_sentence}} looks like a past human job?, respond yes or no"

    if is_yes?(is_valid)
      prompt = "give my professional career as #{job_title} with skills #{skills} write a professional past experiences from these experiences: #{experience.to_sentence}"
      result = make_request(prompt)
      puts "result: #{result}"
      result
  
    elsif 
      raise "Raiseddd"
    end
    
  end


  def make_request(prompt)
    response = response = client.completions(
      parameters: {
        model: "text-davinci-001",
        # input: text,
        max_tokens: 900,
        prompt: prompt
      }
    )

    response.dig("choices", 0, "text")
  end

  def is_yes?(prompt)
    make_request(prompt).includes?("yes")
  end
end