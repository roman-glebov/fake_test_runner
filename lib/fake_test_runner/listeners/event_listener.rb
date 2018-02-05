class EventListener
  def on_fake_project_runner_test_runs_start(event)
    event[:payload].each do |test_run_info|
      call_action(AddTestRun.new.call(test_run_info))
    end
  end

  def on_fake_project_runner_project_run_stop(event)
    event[:payload]['test_run_ids'].each do |id|
      call_action(StopTestRun.new.call(id: id))
    end
  end

  private

  def call_action(response)
    if response.successful?
      Sneakers.publish(response.message, routing_key: response.routing_key)
    else
      Sneakers.publish(response.error, routing_key: response.error_routing_key)
    end
  end
end
