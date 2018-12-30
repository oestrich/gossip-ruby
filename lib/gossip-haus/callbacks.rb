module GossipHaus
  class Callbacks
    def channels
      []
    end

    def players
      []
    end

    def user_agent
      "Gossip Ruby v0.1"
    end

    def broadcast(message)
      p message
    end
  end
end
