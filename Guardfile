# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^lib/rackit_scrobbler\.rb|) { "test" }
  watch(%r|^lib\/rackit_scrobbler\/(.*)\/(.*)\.rb|) { |m| "test/#{m[1]}_#{m[2]}_test.rb" }
  watch(%r|^lib\/rackit_scrobbler\/(.*)\.rb|) { |m| "test/#{m[1]}_test.rb" }
end
