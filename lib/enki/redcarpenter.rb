require 'redcarpet'

class EnkiRender < Redcarpet::Render::HTML
  def block_code(code, language)
    <<-HTML
      <ac:structured-macro ac:name="code">
        <ac:plain-text-body>
          <![CDATA[#{code}]]>
        </ac:plain-text-body>
      </ac:structured-macro>
    HTML
  end
end

module Enki
  module Redcarpenter
    extend self

    def compile_file(source:, output:)
      @data = YAML.load_file(source)
      @markdown = ::Redcarpet::Markdown.new(
        EnkiRender,
        no_intra_emphasis: true,
      )

      template_file = File.open(Enki.configuration.erb_template)

      template = ERB.new template_file.read

      File.open(output, 'w') do |file|
        file.puts template.result(binding)
      end
    end

    def compile_dir(src_dir:, dst_dir:)
      Dir.glob("#{src_dir}/**/*.yml").each do |source_file|
        output_file = "#{dst_dir}/#{source_file[%r{#{src_dir}/(.*)\.yml}, 1]}.html"
        FileUtils.mkdir_p File.dirname(output_file)

        compile_file(source: source_file, output: output_file)
      end
    end
  end
end
