require "confluencer"

module Enki
  module Confluence
    extend self

    def upload(options = {})
      file = options.delete(:file)
      title = options.delete(:title) || File.basename(file, '.*')
      space = options.delete(:space) || Enki.configuration.confluence_space

      content = File.read(file)

      page = Confluence::Page.new({
        space: space,
        title: title,
        content: content
      })

      Enki.logger.log "Uploading page #{title.inspect}..."
      page.store
      Enki.logger.log "Done!"
    end
  end

  def process_dir(dir)
    confluence_session do
      Dir.glob("#{dir}/**/*html").each do |file|
        upload(file: file)
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
