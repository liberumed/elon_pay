import Config

config :elon_pay, ecto_repos: [ElonPay.Repo]

if File.exists?("config/secret.exs") do
  import_config "secret.exs"
else
  IO.puts(
    "Please copy config/example-config.exs to config/secret.exs and provide local configuration"
  )
end


