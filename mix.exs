defmodule Hello.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello,
      version: version_from_git(),
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Hello.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.5"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      ver: &print_version/1
    ]
  end

  defp version_from_git do
    {rev, 0} = System.cmd("git", ["describe", "--always", "--tags"])
    to_sem_ver(String.trim(rev))
  end

  defp print_version(_) do
    Mix.shell().info(version_from_git())
  end

  defp to_sem_ver(ver) do
    case String.split(ver, "-") do
      [tag] -> tag
      [tag, _n, hash] -> tag <> "-" <> hash
    end
  end

  defp releases do
    [
      hello: [
        include_executables_for: [:unix],
        steps: [:assemble, :tar]
      ]
    ]
  end

end
