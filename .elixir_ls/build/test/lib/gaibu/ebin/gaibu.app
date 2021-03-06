{application,gaibu,
             [{applications,[kernel,stdlib,elixir,logger,jason,postgrex,myxql,
                             ecto_sql,plug_cowboy,guardian,cors_plug]},
              {description,"gaibu"},
              {modules,['Elixir.Gaibu','Elixir.Gaibu.Application',
                        'Elixir.Gaibu.NeedAuthenticationRouter',
                        'Elixir.Gaibu.Pipeline','Elixir.Gaibu.Repo',
                        'Elixir.Gaibu.Router','Elixir.Gaibu.Schema.Event',
                        'Elixir.Gaibu.Schema.User',
                        'Elixir.Gaibu.Schema.UserLogin','Elixir.Gaibu.Token',
                        'Elixir.Gaibu.Token.Plug',
                        'Elixir.Jason.Encoder.Gaibu.Schema.Event',
                        'Elixir.Jason.Encoder.Gaibu.Schema.User']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.Gaibu.Application',[]}}]}.
