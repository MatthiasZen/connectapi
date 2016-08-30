class PagesController < ApplicationController
  def index
    require 'net/http'

url = URI.parse('https://eu.api.ovh.com/1.0/auth/time')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
  http.request(req)
}
puts res.body
raise
  end
end

