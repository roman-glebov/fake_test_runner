class TestRepository < Hanami::Repository
  associations do
    has_many :test_runs
  end

  def add_test_run(test, data)
    assoc(:test_runs, test).add(data)
  end
end
