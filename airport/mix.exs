defmodule Airport.Mixfile do
  use Mix.Project

  def project do
    [app: :airport,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison, :sweet_xml]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
   defp deps do
    [
      { :httpoison, "~> 0.4" },
      { :sweet_xml, "~> 0.2.1" }
    ]
  end

  defp escript_config do
    [ main_module: Airport.CLI ]
  end
end
