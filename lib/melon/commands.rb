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
    # TODO: check needs -r
    # TODO: update- a function of add, ignore files that are already present in the db
    # TODO: needs a 'remove' command, or some way to deal with deletes/renames
    #   remove: given a tracked file, removes it
    #           given an untracked file, it hashes it
    #             and attempts to remove it by hash
    # TODO: list needs --paths(only) and --hashes(only)
    # TODO: handle moving a file somehow -- hopefully a function of update
    #          could be:
    #            1.  move file
    #            2.  add new path to db
    #            3.  some sort of cull cmd that removes untracked paths
    # post-1.0
    # TODO: needs a 'verify' command to check integrity of database
    #   both internal 2-hash consistency (consistency) and db<->filesystem
    #   matching up (integrity) [file exists, hashes match]
  end
end
