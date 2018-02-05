require 'hanami/interactor'

class AddTestRun
  include Hanami::Interactor

  expose :message, :routing_key, :error_routing_key

  def initialize(test_repository: TestRepository.new, test_run_repository: TestRunRepository.new)
    @test_repository = test_repository
    @test_run_repository = test_run_repository
    @routing_key = 'fake_test_runner.test_run.start_test'
    @error_routing_key = 'fake_test_runner.test_run.start_test.error'
  end

  def call(attributes)
    result = @test_repository.add_test_run(find_test(attributes['test_id']), pr_test_run_id: attributes['id'])
    @message = { id: result.id }.to_json
  rescue StandardError => e
    error e.message
  end

  private

  def find_test(id)
    @test_repository.find(id)
  end
end
