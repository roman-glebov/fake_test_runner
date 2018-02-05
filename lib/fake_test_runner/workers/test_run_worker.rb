class TestRunWorker
  include Sneakers::Worker
  from_queue 'fake_test_runner.test_run.start_test'

  def work(msg)
    message = JSON.parse(msg)
    repository.find(message['id'].to_i).start_test do
      cancelled?(message['id'])
    end
    cancelled?(id) ? reject! : ack!
  end

  private

  def repository
    @repository ||= TestRunRepository.new
  end

  def cancelled?(jid)
    ::REDIS.with { |c| c.exists("cancelled-#{jid}") }
  end

  def self.cancel!(jid)
    ::REDIS.with { |c| c.setex("cancelled-#{jid}", 86_400, 1) }
  end
end
