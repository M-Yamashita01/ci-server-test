
require 'json'
require "net/http"

params = { payload: { action: 'opened' } }
uri = URI.parse("https://xxx.ngrok-free.app/event_handler")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
header = {
  'HTTP_X_GITHUB_EVENT' => 'pull_request',
  'Content-Type' =>'application/json'
}

puts params.to_json

response = http.post(uri.path, params.to_json, header)

puts response.code # status code
puts response.body # response body