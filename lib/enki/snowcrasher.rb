module Enki
  module Snowcrasher
    extend self

    def compile_file(source:, output:, format: "yaml")
      result = `#{Enki.configuration.snowcrash_binary} --output '#{output}' --format #{format} '#{source}' 2>&1`

      unless $?.success?
        raise "Snowcrasher: Error: #{result}"
      end
    end

    def compile_dir(src_dir:, dst_dir:)
      Dir.glob("#{src_dir}/**/*.md").each do |source_file|
        output_file = "#{dst_dir}/#{source_file[%r{src_dir/(.*)\.md}, 1]}.yml"
        FileUtils.mkdir_p File.dirname(output_file)

        compile_file(source: source_file, output: output_file)
      end
    end
  end
end
