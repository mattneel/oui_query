defmodule OuiQuery.Mixfile do
  use Mix.Project

  def project do
    [
      app: :oui_query,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {OuiQuery.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:ex_doc, "~> 0.18.1"}
    ]
  end

  defp description do
    """
    Library for downloading & querying the latest Wireshark OUI Database
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Matt Neel"],
      licenses: ["MIT"]
    ]
  end
end
