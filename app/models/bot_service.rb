class BotService
  attr_reader  :client, :resume

  delegate :full_name, :job_title, :skills, :experience, to: :resume

  def initialize(resume:)
    @resume = resume
    @client = ::OpenAI::Client.new(access_token: ENV.fetch("CHAT_GPT") )
  end

  def get_resume_short
    is_valid = "does the following inputs looks legit for a resume job title and skills related to that job? answer yes or no, job title: #{job_title} skills #{skills}"
    if is_yes?(is_valid)
      prompt = "Write an intro for my resume as #{job_title} having in mind my background on skills: #{skills}"
      result = make_request(prompt)
      
      puts "result: #{result}"

      result
    else 
      raise "Not valid "
    end
  end

  def get_resume_skills
    prompt = "write a short list of skills related to my job as #{job_title} having this skills on mind: #{skills}"
    result = make_request(prompt)
    
    puts "result: #{result}"

    result
  end

  def get_experience
    is_valid = "the given input surrounded by curly braces {#{experience}} looks like a past human job?, respond yes or no"

    if is_yes?(is_valid)
      prompt = "give my professional career as #{job_title} with skills #{skills} write a professional past experiences from these experiences: #{experience}"
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
    result = make_request(prompt)
    puts "result >>>>>>>> #{prompt} #{result}"
    result.downcase.include?("yes")
  end
end