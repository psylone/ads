module BasicService
  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def self.prepended(base)
    # See https://dry-rb.org/gems/dry-initializer/3.0/skip-undefined/
    base.extend Dry::Initializer[undefined: false]
    base.extend ClassMethods
  end

  attr_reader :errors

  def initialize(*args)
    super(*args)
    @errors = []
  end

  def call
    super
    self
  end

  def success?
    !failure?
  end

  def failure?
    @errors.any?
  end

  private

  def fail!(messages)
    @errors += Array(messages)
    self
  end
end
