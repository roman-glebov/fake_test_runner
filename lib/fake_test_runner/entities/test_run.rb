class TestRun < Hanami::Entity
  def start_test
    sleep rand(7..10)
    running_status
    sleep rand(5..10)
    end_status
  end

  def stop_test
    update_test_run_info('stopped')
  end

  private

  def running_status
    update_test_run_info('running')
  end

  def end_status
    status = %w[finished failed].sample
    update_test_run_info(status)
  end

  def update_test_run_info(status)
    Sneakers.publish({ pr_test_run_id: pr_test_run_id, status: status }.to_json,
                     routing_key: 'fake_test_runner.test_run.update')
  end
end
