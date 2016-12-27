require 'httparty'
require 'json'

module Messages
  include HTTParty

  def get_messages(*page)
    if page == []
      response = Messages.get("#{@base_url}/message_threads",
        headers: { "authorization" => @auth_token }
      )
    else
      response = Messages.get("#{@base_url}/message_threads?page=#{page[0]}",
        headers: { "authorization" => @auth_token }
      )
    end
    @messages = JSON.parse(response.body)
    { message: 'authorized', status: 200 }
  end

  def create_message(sender, recipient_id, token, subject, body)
    response = Messages.post("#{@base_url}/messages",
      query: { "sender" => sender, "recipient_id" => recipient_id,
                "token" => token, "subject" => subject, "stripped-text" => body },
      headers: { "authorization" => @auth_token }
    )
    if response["success"]
      puts "Message has sucessfully sent"
    else
      puts "Message failed to send"
    end
  end

end
