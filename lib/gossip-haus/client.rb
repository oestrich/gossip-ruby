module GossipHaus
  class Client
    attr_reader :client_id, :client_secret, :callbacks

    def initialize(client_id, client_secret, callbacks, gossip_socket_url = nil)
      @client_id = client_id
      @client_secret = client_secret
      @callbacks = callbacks
      @gossip_socket_url = gossip_socket_url || "wss://gossip.haus/socket"
    end

    def start
      @ws = Faye::WebSocket::Client.new(@gossip_socket_url)

      ws.on :open do |event|
        send_authenticate
      end

      ws.on :message do |event|
        json = JSON.parse(event.data)
        process_event(json)
      end

      ws.on :close do |event|
        @ws = nil
        sleep(5)
        start
      end
    end

    def send_message(channel, player_name, message)
      ws.send({
        "event": "channels/send",
        "payload": {
          "channel": channel,
          "name": player_name,
          "message": message
        }
      }.to_json)
    end

    private

    attr_reader :ws

    def process_event(event)
      p event["event"]
      case event["event"]
      when "heartbeat"
        send_heartbeat
      when "channels/broadcast"
        process_broadcast(event)
      end
    end

    def send_authenticate
      ws.send({
        "event": "authenticate",
        "payload": {
          "client_id": client_id,
          "client_secret": client_secret,
          "supports": ["channels"],
          "channels": callbacks.channels,
          "version": "2.2.0",
          "user_agent": callbacks.user_agent
        }
      }.to_json)
    end

    def send_heartbeat
      ws.send({
        "event": "heartbeat",
        "payload": {
          "players": callbacks.players
        }
      }.to_json)
    end

    def process_broadcast(event)
      callbacks.broadcast(Message.new(event["payload"]))
    end
  end
end
