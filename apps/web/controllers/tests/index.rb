module Web::Controllers::Tests
  class Index
    include Web::Action

    accept :json

    expose :tests

    def call(params)
      @tests = TestRepository.new.all
    end
  end
end
