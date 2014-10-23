require 'factor-connector-api'
require 'rest-client'

Factor::Connector.service 'tutum_container' do
  action 'list' do |params|

    username       = params['username']
    api_key        = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      headers = {
        "Authorization"=>"ApiKey #{username}:#{api_key}",
        "Accept" => "application/json"
      }
      container_url = 'https://dashboard.tutum.co/api/v1/container'
      response      = RestClient.get(container_url,headers)
      info 'Parsing list response'
      contents      = JSON.parse(response)
    rescue
      fail 'Failed to list containers'
    end

    action_callback contents
  end
end
