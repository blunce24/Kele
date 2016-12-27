require 'httparty'
require 'json'

module Roadmap
  include HTTParty

  def get_roadmap(roadmap_id)
    response = Roadmap.get("#{@base_url}/roadmaps/#{roadmap_id}",
      headers: { "authorization" => @auth_token }
    )
    @roadmap = JSON.parse(response.body)
    { message: 'authorized', status: 200 }
  end

  def get_checkpoint(checkpoint_id)
    response = Roadmap.get("#{@base_url}/checkpoints/#{checkpoint_id}",
      headers: { "authorization" => @auth_token }
    )
    @checkpoint = JSON.parse(response.body)
    { message: 'authorized', status: 200 }
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    enrollment_id = @user_info["current_enrollment"]["id"]
    response = Roadmap.post("#{@base_url}/checkpoint_submissions",
      query: { "assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link,
                "checkpoint_id" => checkpoint_id, "comment" => comment, "enrollment_id" => enrollment_id },
      headers: { "authorization" => @auth_token }
    )
    if response["status"] == "submitted"
      puts "Submission has sucessfully sent"
      { message: 'authorized', status: 200 }
    else
      puts "Submission failed to send"
      { message: 'unauthorized', status: 404 }
    end
  end

end
