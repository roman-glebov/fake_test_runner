class EventRegister
  include Dry::Events::Publisher[:fake_test_runner_publisher]
  ROUTING_COLLECTION = %w(fake_project_runner.test_runs.start fake_project_runner.project_run.stop).freeze

  ROUTING_COLLECTION.each do |routing|
    register_event(routing)
  end
end
