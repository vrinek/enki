require "confluencer"

module Enki
  module Confluence
    extend self

    def upload(options = {})
      file = options.delete(:file)
      title = options.delete(:title) || File.basename(file, '.*')
      space = options.delete(:space) || Enki.configuration.confluence_space

      content = File.read(file)

      confluence_session do
        page = Confluence::Page.new({
          space: space,
          title: title,
          content: content
        })

        puts "Uploading page #{title.inspect}..."
        page.store
        puts "Done!"
      end
    end
  end

  private
  def confluence_session
    options = {
      url: Enki.configuration.confluence_url,
      username: Enki.configuration.confluence_user,
      password: Enki.configuration.confluence_password
    }

    Confluence::Session.new(options) do |client|
      yield(client)
    end
  end
end
