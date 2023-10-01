require 'json'
require "net/http"

uri = URI.parse("https://api.github.com/repos/M-Yamashita01/RailsSample/hooks")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

req = Net::HTTP::Post.new(uri.request_uri)

req["Accept"] = "application/vnd.github+json"
req["Authorization"] = "Bearer " + ENV['GITHUB_TOKEN']
req["X-GitHub-Api-Version"] = "2022-11-28"

req.body = {
  "name": "web",
  "active": true,
  "events": [
    "pull_request",
    "push"
  ],
  "config": {
    "url": "https://xxx.ngrok-free.app/event_handler",
    "content_type": "form"
  }
}.to_json

http.request(req)
