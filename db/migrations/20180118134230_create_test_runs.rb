Hanami::Model.migration do
  change do
    create_table :test_runs do
      primary_key :id
      foreign_key :test_id, :tests, on_delete: :cascade, null: false

      column :status, String, dafault: 'waiting'
      column :pr_test_run_id, Integer, null: false
      column :progress, Integer
      column :started_at, DateTime
      column :finished_at, DateTime
      column :timeElapsed, Integer
      column :timeRemaining, Integer
      column :grade, String, default: 'N/A'
      column :score, Integer, default: 0
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :test_id
    end
  end
end
