module Push
    @@fcm = ::FCM.new Rails.application.credentials.fcm_server_key

    def self.notice_clients device_tokens,options
        @@fcm.send device_tokens, options
    end
end