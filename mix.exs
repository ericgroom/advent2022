defmodule Advent2022.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent2022,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :ssl, :public_key]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:clipboard, "~> 0.2", only: [:dev, :test]}
    ]
  end
end
