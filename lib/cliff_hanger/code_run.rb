module CliffHanger
  class CodeRun
    attr_reader :code, :result, :error

    def initialize code, binding
      @code = code
      @result = binding.eval(code)
    rescue StandardError => e
      @error = e.to_s
    end

    def to_s
      error || result
    end
  end
end
