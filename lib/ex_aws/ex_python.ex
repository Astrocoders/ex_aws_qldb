defmodule ExAws.ExPython do
  def python_instance(path) when is_list(path) do
    {:ok, pid} = :python.start([{:python, 'python3'}, {:python_path, to_charlist(path)}])
    pid
  end

  def python_instance(_) do
    {:ok, pid} = :python.start()
    pid
  end

  def call_python(pid, module, function, arguments \\ []) do
    pid
    |>:python.call(module, function, arguments)
  end
end
