defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

  test ":help returned by parsing a -h or --help option" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "mundo", "prueba"]) == :help
  end

  test "three values returned if three values passed" do
    assert parse_args(["account","project","5"])  == {"account", "project", 5}
  end

  test "default count returned if two values passed" do
    assert parse_args(["account", "project"]) == {"account", "project", 4}
  end

  test ":help returned when nothing is passed" do
    assert parse_args([""]) == :help
  end

  test ":help returned when an invalid param is passed" do
    assert parse_args(["invalid"]) == :help
    assert parse_args(["--invalid"]) == :help
    assert parse_args(["--invalid","argument"]) == :help
  end
end