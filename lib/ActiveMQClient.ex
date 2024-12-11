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

    # Establish a connection
    case StompClient.connect(options) do
      {:ok, conn} ->
        # Send the message to the specified queue
        case StompClient.send(conn, @queue, message) do
          :ok ->
            IO.puts("Message sent successfully!")
            StompClient.disconnect(conn)

          {:error, reason} ->
            IO.puts("Failed to send message: #{inspect(reason)}")
        end

      {:error, reason} ->
        IO.puts("Failed to connect to ActiveMQ: #{inspect(reason)}")
    end
  end
end
