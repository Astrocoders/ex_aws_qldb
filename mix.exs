defmodule ExAws.QLDB.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_qldb,
      version: "0.1.1",
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
      {:ex_aws, "~> 2.4"},
      {:jason, "~> 1.4"},
      {:hackney, "~> 1.9"},
      {:erlport, "~> 0.9"}
    ]
  end
end
