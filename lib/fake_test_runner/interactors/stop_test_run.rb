require 'hanami/interactor'

class StopTestRun
  include Hanami::Interactor

  expose :message, :routing_key, :error_routing_key

  def initialize(repository: TestRunRepository.new, worker: TestRunWorker)
    @repository = repository
    @worker = worker
    @routing_key = 'fake_test_runner.test_run.stop_test'
    @error_routing_key = 'fake_test_runner.test_run.stop_test.error'
  end

  def call(attributes)
    test_run = @repository.find_by_pr_test_run_id(attributes[:id])
    if @worker.cancel!(test_run.id)
      @message = "TestRun id: #{test_run.id} has been stopped"
    end
  rescue StandardError => e
    error e.message
  end
end
