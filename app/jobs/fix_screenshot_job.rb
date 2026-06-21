class FixScreenshotJob < ApplicationJob
  queue_as :default

  def perform
    Diag.where(screenshot: nil).where.not(lighthouse: nil).each do |diag|
      diag.send(:get_screenshot)
    end
  end
end
