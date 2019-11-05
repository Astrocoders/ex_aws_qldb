defmodule ExAws.QLDB.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_qldb,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:ex_aws, git: "https://github.com/georgelima/ex_aws"},
      {:jason, "~> 1.1"},
      {:hackney, "~> 1.9"},
    ]
  end
end
