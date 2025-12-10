class HomeController < ApplicationController
  def index
  end

  def start_job
    ExampleJob.perform_later("Hello from Sidekiq! This is CHANGED message.")
    redirect_to root_path, notice: "Background job has been enqueued! Please check the logs to see the output."
  end
end
