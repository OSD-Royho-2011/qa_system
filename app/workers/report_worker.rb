class ReportWorker
  include Sidekiq::Worker

  def perform
    puts "Report worker is performing..."
  end
end