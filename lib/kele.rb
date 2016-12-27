require 'httparty'
require 'json'
require 'roadmap'
require 'messages'

class Kele
  include HTTParty
  include Roadmap
  include Messages

  def initialize(email, password)
    @email = email
    @password = password
    @base_url = 'https://www.bloc.io/api/v1'
    authorize
  end

  def authorize
    response = Kele.post("#{@base_url}/sessions",
      body: {email: @email, password: @password}
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{@email} has sucessfully logged in"
      { message: 'authorized', status: 200 }
    else
      puts "Login invalid"
      { message: 'unauthorized', status: 404 }
    end
  end

  def get_me
    response = Kele.get("#{@base_url}/users/me",
      headers: { "authorization" => @auth_token }
    )
    @user_info = JSON.parse(response.body)
    { message: 'authorized', status: 200 }
  end

  def get_mentor_availability(mentor_id)
    response = Kele.get("#{@base_url}/mentors/#{mentor_id}/student_availability",
      headers: { "authorization" => @auth_token }
    )
    @mentor_availability = JSON.parse(response.body)
    { message: 'authorized', status: 200 }
  end

end
