Dir[File.join(File.dirname(__FILE__), "commands/*.rb")].each {|f| require f}

module Melon
  module Commands
    def self.each
      consts = []
      base = self.const_get('Base')
      self.constants.sort.each do |c|
        const = self.const_get(c)

        if const.superclass == base
          consts << const
          yield const 
        end
      end
      consts
    end

    class << self
      alias :[] :const_get
    end

    # TODO: needs a 'verify' command to check integrity of database
    #   both internal 2-hash consistency (consistency) and db<->filesystem
    #   matching up (integrity) [file exists, hashes match]
    # TODO: needs a 'remove' command, or some way to deal with deletes/renames
    #   remove: given a tracked file, removes it
    #           given an untracked file, it hashes it
    #             and removes it by hash
    # TODO: list needs --paths(only) and --hashes(only)
    #            --count
    # TODO: check needs -r
    # TODO: update- a function of add, ignore files that are already present in the db
  end
end
