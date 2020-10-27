defmodule MuffinApi.AuthAccessPipeline do
  use Guardian.Plug.Pipeline,otp_app: :muffin_api,
    error_handler: MuffinApi.AuthErrorHandler,
    module: MuffinApi.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Guardian.Plug.EnsureAuthenticated
end
