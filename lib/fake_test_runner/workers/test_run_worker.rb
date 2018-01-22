class TestRunWorker
  include Sneakers::Worker
  from_queue 'fake_test_runner.test_run.start_test'

  def work(msg)
    message = JSON.parse(msg)
    repository.find(message['id'].to_i).start_test
    ack!
  end

  private

  def repository
    @repository ||= TestRunRepository.new
  end
end
