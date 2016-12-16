require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = Kele.post("#{@base_url}/sessions",
      body: {email: email, password: password}
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} is sucessfully in with auth_token #{@auth_token}"
    else
      puts "Login invalid"
    end
  end

end
