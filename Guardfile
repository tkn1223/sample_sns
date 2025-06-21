guard :rspec, cmd: "bundle exec rspec" do
  # app/controllers 配下の変更 → spec/controllers 以下を実行
  watch(%r{^app/controllers/(.+)\.rb$})    { |m| "spec/controllers/#{m[1]}_spec.rb" }
  # app/models 配下の変更 → spec/models 以下を実行
  watch(%r{^app/models/(.+)\.rb$})         { |m| "spec/models/#{m[1]}_spec.rb" }
  # lib 配下の変更 → spec/lib 以下を実行
  watch(%r{^lib/(.+)\.rb$})                { |m| "spec/lib/#{m[1]}_spec.rb" }
  # spec ファイル自身の変更
  watch(%r{^spec/.+_spec\.rb$})
  # サポートファイルの変更 → 全 spec を再実行
  watch('spec/rails_helper.rb')            { "spec" }
  watch('spec/spec_helper.rb')             { "spec" }
end