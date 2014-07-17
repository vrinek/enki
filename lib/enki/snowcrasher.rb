module Enki
  module SnowCrasher
    extend self

    def compile_file(options = {})
      src = options.delete(:source)
      dst = options.delete(:output)
      format = options.delete(:format) || "yml"

      result = `#{Enki.configuration.snowcrash_path} --ouput #{dst} --format #{format} #{src} 2>&1`

      unless $?.success?
        raise "SnowCrasher: Error: #{result}"
      end
    end

    def compile_dir(options = {})
      src_dir = options.delete(:src_dir)
      dst_dir = options.delete(:dst_dir)

      Dir.glob("#{src_dir}/**/*.md").each do |src_file|
        output_file = "#{dst_dir}/#{source_file[%r{src_dir/(.*)\.md}, 1]}.yml"
        FileUtils.mkdir_p File.dirname(output_file)

        compile_file(source: src_file, output: output_file)
      end
    end
  end
end
