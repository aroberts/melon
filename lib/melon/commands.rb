Dir[File.join(File.dirname(__FILE__), "commands/*.rb")].each {|f| require f}

module Melon
  module Commands
    def self.each
      consts = []
      self.constants.sort.each do |c|
        const = self.const_get(c)

        if const.respond_to?(:superclass) && const.superclass == Base
          consts << const
          yield const 
        end
      end
      consts
    end

    class << self
      alias :[] :const_get
    end


    # 1.0 list
    # TODO: needs a 'remove' command, or some way to deal with deletes/renames
    #   remove: given a tracked file, removes it
    #           given an untracked file, it hashes it
    #             and attempts to remove it by hash
    # TODO: list needs --paths(only) and --hashes(only)
    #
    # post-1.0
    # TODO: needs a 'verify' command to check integrity of database
    #   both internal 2-hash consistency (consistency) and db<->filesystem
    #   matching up (integrity) [file exists, hashes match]
  end
end
