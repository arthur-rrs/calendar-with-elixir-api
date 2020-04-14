defmodule Gaibu.NeedAuthenticationRouter do
  use Plug.Router
  import Ecto.Query, only: [from: 2]

  plug :match
  plug Gaibu.Pipeline
  plug Plug.Parsers, parsers: [:urlencoded, :json],json_decoder: Jason
  plug :dispatch

  post "/event" do
    claims = Gaibu.Token.Plug.current_claims(conn)
    input = Gaibu.Schema.Event.changeset(%Gaibu.Schema.Event{}, conn.body_params)
    if (false == input.valid?) do
      errors = Gaibu.Router.prepare_error_response(input.errors)
      Gaibu.Router.bad_request(conn, errors)
    else
      id = claims["sub"]
      user_id = to_string(input.changes.user_id)
      if id == user_id do
        case Gaibu.Repo.insert(input) do
          {:ok, struct} -> Gaibu.Router.created(conn, struct)
          {:error, changeset} -> Gaibu.Router.bad_request(conn, Gaibu.Router.prepare_error_response(changeset))
        end
      else
        Gaibu.Router.unauthorized(conn, "not_authorized")
      end
    end
    Gaibu.Router.ok(conn)
  end

  get "/myevents" do
    claims = Gaibu.Token.Plug.current_claims(conn)
    {id, _} = Integer.parse(claims["sub"])
    query = from e in Gaibu.Schema.Event,
              where: e.user_id == ^id,
              select: e
    Gaibu.Router.ok(conn, Gaibu.Repo.all(query))
  end

end
