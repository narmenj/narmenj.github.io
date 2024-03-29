require "stringex"
class Jekyll < Thor
  desc "new", "create a new post"
  method_option :editor, :default => "remarkable"
  def new(*title)
    title = title.join(" ")
    date = Time.now.strftime('%Y-%m-%d')
    time = Time.now.strftime("%H:%M:%S")
    filename = "_posts/#{date}-#{title.to_url}.markdown"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{date} #{time} +0330"
      post.puts "excerpt_separator: <!--more-->"
      post.puts "categories:"
      post.puts " -"
      post.puts "---"
    end

    system(options[:editor], filename)
  end
end
