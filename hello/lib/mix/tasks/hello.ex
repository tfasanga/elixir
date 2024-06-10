defmodule Mix.Tasks.Hello do
  @moduledoc "The hello mix task"
  use Mix.Task

  @shortdoc "Simply calls"
  def run(_) do
    Mix.Task.run("app.start")
    Hello.say()
  end
end