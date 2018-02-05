class TestRunRepository < Hanami::Repository
  def find_by_pr_test_run_id(id)
    test_runs.where(pr_test_run_id: id).one
  end
end
