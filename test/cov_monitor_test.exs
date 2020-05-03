defmodule CovMonitorTest do
  use ExUnit.Case
  doctest CovMonitor

  test "greets the world" do
    assert CovMonitor.hello() == :world
  end
end
