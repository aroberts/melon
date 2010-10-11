require 'rubygems'
require 'sqlite3'

module Melon
  class Database

    attr_reader :path, :db

    def initialize(path)
      @path = path
      needs_create = true unless File.exist?(path)
      @db = SQLite3::Database.new(path)

      create_schema if needs_create
    end

    #database exists, table created
    # ready could prepare some sort of error state - 
    # * database file is valid/not - quick_check
    # * table is created/not - table_info(table_name)
    # * index is created/not - index_info(index_name)
    def ready?
      file_ready? && table_ready? && index_ready?
    end

    def file_ready?
      begin
        @db.execute("PRAGMA quick_check").flatten[0] == 'ok'
      rescue SQLite3::NotADatabaseException
        false
      end
    end

    def index_ready?
      begin
        !db.execute("pragma index_info(idx_fingerprints)").empty?
      rescue SQLite3::NotADatabaseException
        false
      end
    end

    def table_ready?
      begin
        !db.execute("pragma table_info(fingerprints)").empty?
      rescue SQLite3::NotADatabaseException
        false
      end
    end

    # how will the Fingerprint object get at the database session?
    # consider activerecord again
    # init should establish_connection
    def create_schema
      db.execute("create table fingerprints(
                  id int primary key,
                   hash varchar(40) not null,
                   path varchar(1000) not null
                )")
      db.execute("create unique index idx_fingerprints
                 on fingerprints(hash)")
    end
  end
end
