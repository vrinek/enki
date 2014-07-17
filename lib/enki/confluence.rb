require "confluencer"

module Enki
  module Confluence
    extend self

    def upload(file:, title: nil, space: nil)
      confluence_session do |client|
        upload_with_client(file: file, client: client, title: title, space: space)
      end
    end

    def process_dir(src_dir:)
      confluence_session do |client|
        Dir.glob("#{src_dir}/**/*.html").each do |file|
          upload_with_client(file: file, client: client)
        end
      end
    end

    private

    def upload_with_client(file:, client:, title: nil, space: nil)
      title ||= File.basename(file, '.*')
      space ||= Enki.configuration.confluence_space

      content = File.read(file)

      old_page = begin
        client.get_page(space, title)
      rescue ::Confluence::Error
        # Page does not exist yet
        nil
      end

      if old_page
        Enki.logger.info "Updating #{old_page["title"].inspect} in #{old_page["space"].inspect}..."
        client.update_page({
          "id" => old_page["id"],
          "space" => old_page["space"],
          "title" => old_page["title"],
          "content" => content,
          "version" => old_page["version"],
        }, {})
      else
        Enki.logger.info "Creating #{title.inspect} in #{space.inspect}..."
        client.store_page({
          "space" => space,
          "title" => title,
          "content" => content,
        })
      end
      Enki.logger.info "Done!"
    end

    def confluence_session
      options = {
        url: Enki.configuration.confluence_url,
        username: Enki.configuration.confluence_user,
        password: Enki.configuration.confluence_password
      }

      ::Confluence::Session.new(options) do |client|
        yield(client)
      end
    end
  end
end
