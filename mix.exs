defmodule ActiveMqSender.MixProject do
  use Mix.Project

  def project do
    [
      app: :active_mq_sender,
      version: "0.2.1",
      elixir: "~> 1.16",
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
      {:stomp_client, "~> 0.1.1"} # Ensure this version is compatible
    ]
  end
end
