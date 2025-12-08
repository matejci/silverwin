class ExampleJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "Processing background job with message: #{message}"
    sleep 2
    Rails.logger.info "Background job completed!"
  end
end
