namespace :enki do
  desc "Generate AST files"
  task :generate_ast => :environment do
    Enki::Snowcrasher.compile_dir(src_dir: "doc", dst_dir: "doc_ast")
  end

  desc "Generate html from AST"
  task :ast_to_html => :generate_ast do
    Enki::Redcarpenter.compile_dir(src_dir: "doc_ast", dst_dir: "doc_html")
  end

  desc "Upload documentation to confluence"
  task :upload_to_confluence => :ast_to_html do
    Enki::Confluence.process_dir(src_dir: "doc_html")
  end
end
