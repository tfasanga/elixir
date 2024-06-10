defmodule SimpleQueue do
  use GenServer


  @doc """
  GenServer.init/1 callback
  """
  def init(state) do
    {:ok, state}
  end

  @doc """
  GenServer.handle_call/3 callback
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API / Helper functions

  def start_link(state \\ []) do
    GenServer.start_link(SimpleQueue, state, name: SimpleQueue)
  end

  def queue do
    GenServer.call(SimpleQueue, :queue)
  end

  def dequeue do
    GenServer.call(SimpleQueue, :dequeue)
  end

  def enqueue(value) do
    GenServer.cast(SimpleQueue, {:enqueue, value})
  end
end
