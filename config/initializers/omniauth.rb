# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2,
#     Rails.application.secrets.google_client_id,
#     Rails.application.secrets.google_client_secret,
#     {
#       scope: "https://www.googleapis.com/auth/userinfo.email,
#               https://www.googleapis.com/auth/userinfo.profile",
#       prompt: "select_account",
#       access_type: "offline"
#     }
# end