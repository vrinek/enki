# Enki

Enki helps avoid Confluence-related pains by moving your API documentation to your code base (`doc/xxx.md`) while allowing easy and painless upload to Confluence.

## Installation

Add this line to your application's Gemfile:

    gem 'enki'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enki

## Dependencies

This gem depends on the [`snowcrash`](https://github.com/apiaryio/snowcrash) binary.

## Configuration

Add a configuration file to your rails project, (for example at `config/initializers/enki.rb`):

```ruby
Enki.configure do |c|
    c.confluence_user = ENV['CONFLUENCE_USERNAME']
    c.confluence_password = ENV['CONFLUENCE_PASSWORD']
    c.confluence_url = 'https://confluence.domain.com/confluence'
    c.confluence_space = 'API'

    c.snowcrash_binary = `which snowcrash`.strip
end
```

## Usage

This gem provides 3 rake tasks:

- `rake enki:generate_ast` - Generates yaml files in `tmp/enki` by parsing every file in `doc/`
- `rake enki:ast_to_html` - Loads the yaml files and renders one html per yaml
- `rake enki:upload_to_confluence` - Uploads the rendered html to confluence by using the configuration variables

Note that each rake task calls the previous one, thus a realistic workflow is to just call `rake enki:upload_to_confluence`.

If you see too much getting uploaded, `rm tmp/enki` and try again.

## TODO

- Whitelist doc files to process
- Better output/verbosity of rake tasks
- Fail on missing configuration settings early and obvious

## Contributing

1. Fork it ( https://github.com/vrinek/enki/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
