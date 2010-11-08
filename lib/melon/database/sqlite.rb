require 'rubygems'
require 'active_record'

require 'melon/fingerprint'

module Melon
  class Database

    attr_reader :path

    def initialize(path)
      @path = path

      ActiveRecord::Base.establish_connection(:adapter => 'sqlite3',
                                              :database => path)
      # begin
      # TODO: rescue in CLI, or throw somewhere else.  Each 
      # command shouldn't be responsible for instantiating this class
      
      create_schema unless Fingerprint.table_exists?
      # rescue ActiveRecord::StatementInvalid
      #   puts "melon: the file '#{path}' is invalid or corrupt."
      #   exit 1
      # end
    end

    def create_schema
      ActiveRecord::Base.connection.create_table(:fingerprints) do |t|
        t.column :digest, :string, :null => false
        t.column :file, :string, :null => false
        t.column :filetype, :string
        t.timestamps

        # TODO: unique indexes
        # t.index :hash, :unique => true
        # t.index :path, :unique => true
      end
    end
  end
end
