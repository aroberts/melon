require 'rubygems'
require 'aruba'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze
BIN_PATH = File.join(PROJECT_ROOT, 'bin').freeze
LIB_PATH = File.join(PROJECT_ROOT, 'lib').freeze

ENV['PATH'] = [BIN_PATH, ENV['PATH']].join(':')
ENV['RUBYLIB'] = LIB_PATH
