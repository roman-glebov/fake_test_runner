class TestRepository < Hanami::Repository
  associations do
    has_many :test_runs
  end

  def add_test_run(test, data)
    assoc(:test_runs, test).add(data)
  end

  def find_last_test_run(id)
    test_runs.where(test_id: id).last
  end
end
