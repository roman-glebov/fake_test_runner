class TestRun < Hanami::Entity
  def start_test
    %w(running finished).each do |status|
      sleep rand(7..10)
      return stop_test if yield
      update_test_run_info(status)
    end
  end

  private

  def stop_test
    update_test_run_info('stopped')
  end

  def update_test_run_info(status)
    Sneakers.publish({ pr_test_run_id: pr_test_run_id, status: status }.to_json,
                     routing_key: 'fake_test_runner.test_run.update')
  end
end
