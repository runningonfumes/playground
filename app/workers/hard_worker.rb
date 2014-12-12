class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
    sleep 5
    puts 'doing more work'
    sleep 2
    puts 'done'
  end
end