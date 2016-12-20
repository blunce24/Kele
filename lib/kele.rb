require 'httparty'
require 'json'
require 'roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = Kele.post("#{@base_url}/sessions",
      body: {email: email, password: password}
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} has sucessfully logged in"
    else
      puts "Login invalid"
    end
  end

  def get_me
    response = Kele.get("#{@base_url}/users/me",
      headers: { "authorization" => @auth_token }
    )
    @user_info = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = Kele.get("#{@base_url}/mentors/#{mentor_id}/student_availability",
      headers: { "authorization" => @auth_token }
    )
    @mentor_availability = JSON.parse(response.body)
  end

end
