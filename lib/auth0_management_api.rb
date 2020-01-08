require 'uri'
require 'net/http'
require 'openssl'
require 'json'
module Auth0ManagementAPI


    ACCESS_TOKEN = {
        token: nil,
        expired_after: nil
    }

    DOMAIN = "https://dev-bt48hc1v.auth0.com/api/v2/"

    def self.pull_token_with_metadata 
        url = URI("https://dev-bt48hc1v.auth0.com/oauth/token")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/json'
        request.body = "{\"client_id\":\"R1CaCN8PvGO00k4Uu0k1jvzExlcjUVU2\",\"client_secret\":\"sWBe8kOi2OKo_95Whnsz1r85qwqgQ1WLfwZdJJoRE7bCkbVXrXyhz72zjzIrskkY\",\"audience\":\"https://dev-bt48hc1v.auth0.com/api/v2/\",\"grant_type\":\"client_credentials\"}"

        response = http.request(request)
        JSON.parse response.read_body
    end

    def self.need_to_reAcquire_token
        ACCESS_TOKEN['token'].nil? || ACCESS_TOKEN['expired_after'].nil? || Time.now > ACCESS_TOKEN['expired_after']
    end

    def self.acquire_access_token 
        tWM = self.pull_token_with_metadata
        ACCESS_TOKEN['token'] = tWM['access_token']
        ACCESS_TOKEN['expire_after'] = Time.now + tWM['expires_in']
    end

    def self.delete_user user_id 
        self.acquire_access_token if self.need_to_reAcquire_token
        uri = URI(URI.escape "https://dev-bt48hc1v.auth0.com/api/v2/users/#{user_id}")
        res = Net::HTTP.start(uri.host,uri.port,use_ssl: true) do |http|
            req = Net::HTTP::Delete.new(uri)
            req["Content-Type"] = "application/json; charset=utf-8"
            req["Authorization"] = "Bearer #{ACCESS_TOKEN['token']}"
            http.request(req)
        end
        res.code == 204
    end

    def self.assign_roles_to_user user_id,roles = ["rol_JmOwxebNacaZBCH5"]
        self.acquire_access_token if self.need_to_reAcquire_token
        uri = URI(URI.escape "https://dev-bt48hc1v.auth0.com/api/v2/users/#{user_id}/roles")
        res = Net::HTTP.start(uri.host,uri.port,use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json; charset=utf-8"
            req["Authorization"] = "Bearer #{ACCESS_TOKEN['token']}"
            req.body = {
                roles: roles
            }.to_json
            http.request(req)
        end
        res.code == 204
    end
end