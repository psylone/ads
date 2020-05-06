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

  def call
    super
    self
  end

end
