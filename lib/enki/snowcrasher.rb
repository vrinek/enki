module Enki
  module SnowCrasher
    extend self

    def compile_file(source:, output:, format: "yml")
      result = `#{Enki.configuration.snowcrash_path} --output #{output} --format #{format} #{source} 2>&1`

      unless $?.success?
        raise "SnowCrasher: Error: #{result}"
      end
    end

    def compile_dir(src_dir:, dst_dir:)
      Dir.glob("#{src_dir}/**/*.md").each do |src_file|
        output_file = "#{dst_dir}/#{source_file[%r{src_dir/(.*)\.md}, 1]}.yml"
        FileUtils.mkdir_p File.dirname(output_file)

        compile_file(source: src_file, output: output_file)
      end
    end
  end
end
