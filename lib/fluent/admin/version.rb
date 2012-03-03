module Fluent
  module Admin
    VERSION = [0, 1, 0]

    def self.version
      VERSION.join(".")
    end
  end
end
