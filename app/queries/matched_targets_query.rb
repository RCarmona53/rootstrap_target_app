class MatchedTargetsQuery
    def self.call(user_id, topic_id)
      Target.exclude_current_user(user_id).with_same_topic(topic_id)
    end
  end
