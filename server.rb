require 'sinatra'
require 'json'
require 'octokit'

before do
  token = ENV['GITHUB_TOKEN']
  @client ||= Octokit::Client.new(access_token: token)
end

post '/event_handler' do
  @payload = JSON.parse(params["payload"])

  case request.env['HTTP_X_GITHUB_EVENT']
  when "pull_request"
    if @payload["action"]
      process_pull_request(@payload["pull_request"])
    end
  end
end

helpers do
  def process_pull_request(pull_request)
    @client.create_status(pull_request['base']['repo']['full_name'], pull_request['head']['sha'], 'pending', context: 'ci-server-test' )
    sleep 10
    @client.create_status(pull_request['base']['repo']['full_name'], pull_request['head']['sha'], 'success', context: 'ci-server-test' )
    puts "Pull request processed!"
  end
end
