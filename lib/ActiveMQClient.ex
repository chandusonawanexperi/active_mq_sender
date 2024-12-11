defmodule ActiveMQClient do
  @moduledoc """
  A simple module to send messages to ActiveMQ using the stomp_client library.
  """
 alias StompClient

  @active_mq_host "localhost"
  @active_mq_port 61613
  @username "admin"
  @password "admin"
  @queue "/queue/example-queue"

  def send_message(message) do
    # Configure connection options
    options = [
      host: @active_mq_host,
      port: @active_mq_port,
      login: @username,
      passcode: @password
    ]

     # Connect to ActiveMQ
     case StompClient.connect(options) do
      pid when is_pid(pid) ->
        IO.puts("Connected successfully: #{inspect(pid)}")

        # Send the message
        case StompClient.send(pid, @queue, message) do
          :ok ->
            IO.puts("Message sent successfully!")
            StompClient.disconnect(pid)

          {:error, reason} ->
            IO.puts("Failed to send message: #{inspect(reason)}")
            StompClient.disconnect(pid)

          unexpected ->
            IO.puts("Unexpected response from send: #{inspect(unexpected)}")
            StompClient.disconnect(pid)
        end

      unexpected ->
        IO.puts("Failed to connect to ActiveMQ. Response: #{inspect(unexpected)}")
    end
  end
end
