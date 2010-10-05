namespace :rcov do
  desc "Run both specs and features to generate aggregated coverage"
  task :all do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task['spec:rcov'].invoke
    Rake::Task["features:rcov"].invoke
  end
end

