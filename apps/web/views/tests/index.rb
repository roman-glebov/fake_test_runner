module Web::Views::Tests
  class Index
    include Web::View

    def render
      raw JSON.generate(tests.map(&:to_h))
    end
  end
end
