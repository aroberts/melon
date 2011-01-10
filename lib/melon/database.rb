require 'pstore'

require 'melon/fingerprint'

module Melon
  class Database

    attr_reader :path, :store

    def initialize(path)
      @path = path

      @store = PStore.new(path)

    end

    def put(fingerprint)

    end

    def get(digest)

    end

    # alias [] to get
  end
end
