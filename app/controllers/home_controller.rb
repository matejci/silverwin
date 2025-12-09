class HomeController < ApplicationController
  def index
  end

  def start_job
    ExampleJob.perform_later("Hello from Sidekiq! This is Matej's Silverwin DEMO message.")
    redirect_to root_path, notice: "Background job has been enqueued!"
  end
end
