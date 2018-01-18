module Web::Controllers::Tests
  class Create
    include Web::Action

    params do
      required(:name).filled
      optional(:description).filled
      required(:type).filled
    end

    accept :json

    expose :test_data

    def call(params)
      @test_data = TestRepository.new.create(params.to_h)
    end
  end
end
