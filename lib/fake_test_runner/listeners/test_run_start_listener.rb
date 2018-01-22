class TestRunStartListener
  include Sneakers::Worker
  from_queue 'fake_project_runner.test_runs.start'

  def work(msg)
    message = JSON.parse(msg)
    message.each do |test_run_info|
      result = AddTestRun.new.call(test_run_info)
      if result.successful?
        Sneakers.publish({ id: result.test_run.id }.to_json, routing_key: 'fake_test_runner.test_run.start_test')
      else
        Sneakers.publish(result.error, routing_key: 'fake_test_runner.test_run.create.error')
      end
    end
    ack!
  end
end
