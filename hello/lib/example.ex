defmodule Example do
  def add(a, b) do
    IO.puts(a + b)
  end

  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
    end
    listen()
  end

  def explode do
    exit(:kaboom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Example, :explode, [])

    receive do
      {:EXIT, _from_pid, reason} -> IO.puts("Exit reason #{reason}")
    end
  end

  def run_m do
    spawn_monitor(Example, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} -> IO.puts("Exit reason #{reason}")
    end
  end

  def double(x) do
    :timer.sleep(2000)
    x * 2
  end


end
