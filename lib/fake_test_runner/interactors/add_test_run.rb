require 'hanami/interactor'

class AddTestRun
  include Hanami::Interactor

  expose :test_run

  def initialize(test_repository: TestRepository.new, test_run_repository: TestRunRepository.new)
    @test_repository = test_repository
    @test_run_repository = test_run_repository
  end

  def call(attributes)
    result = @test_repository.add_test_run(find_test(attributes['test_id']), pr_test_run_id: attributes['id'])
    @test_run = @test_run_repository.find(result.id)
  rescue StandardError => e
    error e.message
  end

  private

  def find_test(id)
    @test_repository.find(id)
  end
end
