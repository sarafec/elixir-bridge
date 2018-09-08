## Mix
* Mix is a build to for Elixir to build elixir apps
* hex is a package maangeer in elixir.
* The `Mix.exs` file contains project information/build instructions for your application.
* `def project` defines what is needed in order for your application to compile. 
* `def application` defines what is needed for your application to run.
* `defp deps` defines the dependencies that are required for the application.
* `cowboy` is an HTTP server for erlang/elixir.
* `plug` is a specification tool and a connection adapter for web servers.
* Document a module using `@moduledoc`, a document function using `@doc`, and spec a function using `@spec`.
* To create our documentation, we'll use two packages - `:earmark` and `:exdoc`. `:earmark` is a pure Elixir markdown converter. `:exdoc` is a documentation generation tool for Elixir.
* To retrieve dependencies use `mix deps.get`.
* Generate documentation using `mix docs`.
* `Plug` provides a common interface for handling connections. `Plug` can take two shapes - receives a connection and a set of options as arguments or returns the connection.
* Use `Plug.Router` is used to match and dispatch requests. `Plug.Router` is a plug that contains its own plug pipeline.
* `Poison` is a JSON library for Elixir.

## GenServer
* The OTP library provides an interface called `GenServer`. 
* A `GenServer` is a process that listens for messages. We can send 3 different types of messages to our `GenServer` process. 
  
The most basic message uses native Erlang message passing. When the GenServer receives a message in this way, the `handle_info/2` callback is called. 
```
defmodule MyApp.ApiHandler do
    use GenServer
    def handle_info(term, state) do
        {:noreply, state}
    end
end
```
   
The next type of message is when we send a message to the GenServer and wait for the response. In this case the `handle_call/3` function will receive the message.
```
defmodule MyApp.ApiHandler do
    use GenServer
    def handle_call(request, from, state) do
        {:reply, response, state}
    end
end
```
  
The last type of message is when we send a message and not wait for a response. `GenServer` will call the `handle_cast/2` callback to handle these messages.
```
defmodule MyApp.ApiHandler do
    use GenServer
    def handle_cast(request, state) do
        {:noreply, state}
    end
end
```