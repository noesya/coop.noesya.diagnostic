class SlackNotification
  def self.push(message)
    return unless ENV['slack_hook']
    slack = Slack::Incoming::Webhooks.new ENV['slack_hook']
    slack.post message
  end
end
