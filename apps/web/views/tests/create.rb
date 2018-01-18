module Web::Views::Tests
  class Create
    include Web::View

    def render
      raw JSON.generate(test_data.to_h)
    end
  end
end
