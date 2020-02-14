require "capybara/poltergeist"
require "capybara-screenshot/rspec"
Capybara.asset_host = "http://localhost:3000"
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist_debug do |app|
   Capybara::Poltergeist::Driver.new(app, {  js_errors: true,
                                            phantomjs_options: ['--ignore-ssl-errors=yes', '--ssl-protocol=any'],
                                             timeout: 240
   })
end

Capybara.register_driver :poltergeist do |app|
  options = {
    phantomjs_options: ['--ssl-protocol=any', '--ignore-ssl-errors=yes'],
    inspector: false
  }
  Capybara::Poltergeist::Driver.new(app, options)
end
