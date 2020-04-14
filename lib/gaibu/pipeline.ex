defmodule Gaibu.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :gaibu,
    module: Gaibu.Token,
    error_handler: __MODULE__

  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: false

  def auth_error(conn, {type, reason}, opts) do
    body = to_string(type)
    IO.inspect(reason)
    IO.inspect(opts)
    conn |>
      put_resp_content_type("application/json")
      |> send_resp(401, body)
  end
end
