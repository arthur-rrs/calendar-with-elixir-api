defmodule Gaibu.Router do

  use Plug.Router
  plug CORSPlug, origin: ["*"], expose: ["x-token"]
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json],json_decoder: Jason
  plug :dispatch

  post "/login" do
    input = Gaibu.Schema.UserLogin.changeset(%Gaibu.Schema.User{}, conn.body_params)
    if true == input.valid? do
      email = input.changes.email
      plain_password = input.changes.password
      result = Gaibu.Schema.UserLogin.authenticate_user(email, plain_password)
      case result do
        {:ok, user} -> {
          conn
          |> Gaibu.Token.Plug.sign_in(user)
          |> send_resp_login(user)
        }
        {:error, x} -> unauthorized(conn, to_string(x))
      end
    else
      bad_request(conn, prepare_error_response(input.errors))
    end
  end

  post "/user" do
    input = Gaibu.Schema.User.changeset(%Gaibu.Schema.User{}, conn.body_params)
    if true == input.valid? do
      try do
        case Gaibu.Repo.insert!(input) do
          {:ok, struct} -> created(conn, struct)
          {:error, changeset} -> bad_request(conn, prepare_error_response(changeset))
        end
      rescue
        e in Ecto.ConstraintError -> conflict(conn, e.constraint)
      end
    else
      errors = prepare_error_response(input.errors)
      bad_request(conn, errors)
    end
  end

  get "/teste" do
    IO.inspect(Mix.env())
    ok(conn)
  end

  forward "/api", to: Gaibu.NeedAuthenticationRouter

  match _ do
    not_found(conn)
  end

  def prepare_error_response(errors) do
    errors |>
    Enum.map(fn value ->
        {key, {message, _}} = value
        Tuple.to_list({key, message})
    end)
  end

  def send_resp_login(conn, user) do
    token = Gaibu.Token.Plug.current_token(conn)
    conn
    |> put_resp_header("x-token", token)
    |> send_resp(200, Jason.encode!(user))
  end

  def bad_request(conn, body) do
    send_resp(conn, 400, Jason.encode!(body))
  end

  def created(conn, body) do
    send_resp(conn, 201, Jason.encode!(body))
  end

  def conflict(conn, body) do
    send_resp(conn, 409, Jason.encode!(body))
  end

  def not_found(conn, body \\ "Opss.. Página não encontrada") do
    send_resp(conn, 404, Jason.encode!(body) )
  end

  def ok(conn, body \\ "") do
    send_resp(conn, 200, Jason.encode!(body))
  end

  def unauthorized(conn, body) do
    send_resp(conn, 401, body)
  end

end
