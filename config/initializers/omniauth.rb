OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['726375684109637'], ENV['377d74e012651e3343eb4a2ebd87f412'], scope:"email, user_tagged_places"
  provider :facebook, '726375684109637', '377d74e012651e3343eb4a2ebd87f412', scope: "email, user_tagged_places, user_friends"
  
  if Rails.env.development? 
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 
end


end
