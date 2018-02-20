defmodule Cobs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cobs,
      version: "0.1.2",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "COBS",
      source_url: "https://github.com/krodelin/cobs-elixir",
      homepage_url: "https://github.com/krodelin/cobs-elixir",
      docs: [
        main: "Cobs", # The main page in the docs
        # logo: "path/to/logo.png",
        extras: ["README.md"],
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp description() do
    "Elixir implementation of Consistent Overhead Byte Stuffing"
  end

  defp package() do
    [
      name: "cobs",
      maintainers: ["Udo Schneider"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/krodelin/cobs-elixir"
      }
    ]
  end
end
