require 'json'
require "net/http"
require 'pp'

uri = URI.parse("https://api.github.com/repos/M-Yamashita01/RailsSample/hooks")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme === "https"

req = Net::HTTP::Get.new(uri.request_uri)

req["Accept"] = "application/vnd.github+json"
req["Authorization"] = "Bearer " + ENV['GITHUB_TOKEN']
req["X-GitHub-Api-Version"] = "2022-11-28"


response = http.request(req)

puts response.code # status code
puts JSON.parse(response.body) # response body