module GossipHaus
  class Message
    attr_reader :channel, :game, :name, :message

    def initialize(payload)
      @channel = payload["channel"]
      @game = payload["game"]
      @name = payload["name"]
      @message = payload["message"]
    end
  end
end
