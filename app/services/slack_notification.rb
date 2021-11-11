class SlackNotification
  def self.push(message)
    return unless ENV['SLACK_HOOK']
    slack = Slack::Incoming::Webhooks.new ENV['SLACK_HOOK']
    slack.post message
  end
end
