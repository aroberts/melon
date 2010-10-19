require 'rubygems'
require 'active_record'

require 'melon/fingerprint'

module Melon
  class Database

    attr_reader :path, :db

    def initialize(path)
      @path = path

      ActiveRecord::Base.establish_connection(:adapter => 'sqlite3',
                                              :database => path)
      begin
        create_schema unless Fingerprint.table_exists?
      rescue ActiveRecord::StatementInvalid
        puts "melon: the file '#{path}' is invalid or corrupt."
        exit 1
      end
    end

    # #database exists, table created
    # # ready could prepare some sort of error state - 
    # # * database file is valid/not - quick_check
    # # * table is created/not - table_info(table_name)
    # # * index is created/not - index_info(index_name)
    # def ready?
    #   file_ready? && table_ready? && index_ready?
    # end

    # def file_ready?
    #   begin
    #     @db.execute("PRAGMA quick_check").flatten[0] == 'ok'
    #   rescue SQLite3::NotADatabaseException
    #     false
    #   end
    # end

    # def index_ready?
    #   begin
    #     !db.execute("pragma index_info(idx_fingerprints)").empty?
    #   rescue SQLite3::NotADatabaseException
    #     false
    #   end
    # end

    # def table_ready?
    #   begin
    #     !db.execute("pragma table_info(fingerprints)").empty?
    #   rescue SQLite3::NotADatabaseException
    #     false
    #   end
    # end

    def create_schema
      ActiveRecord::Base.connection.create_table(:updates) do |t|
        t.column :hash, :string, :null => false
        t.column :path, :string, :null => false
        t.timestamps

        # t.index :hash, :unique => true
        # t.index :path, :unique => true
      end
    end
  end
end
