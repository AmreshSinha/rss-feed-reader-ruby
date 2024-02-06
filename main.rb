#!/usr/bin/env ruby

require 'thor'
require 'rss'
require 'open-uri'

# def main
#     if ARGV.empty?
#         puts 'Usage: ./main.rb <your_name>'
#         exit
#     end

#     name = ARGV[0]
#     puts "Hello, #{name}!"
# end

# main if __FILE__ == $PROGRAM_NAME

# TODO: (Part of) Write a RSS parser from scratch
def extract_data(tag, string)
    # puts "Tag: #{tag}"
    tag_regex = /<#{tag}>(.*?)<\/#{tag}>/
    # if tag == "link"
    #     puts "#{tag}: #{string}"
    #     puts string.scan(tag_regex.flatten)
    # end
    string.scan(tag_regex).flatten
end

class RSSReaderCli < Thor
    desc 'hello NAME', 'Greets the user with the provided NAME'
    def hello(name)
        puts "Hello, #{name}!"
    end

    desc 'read RSS-FEED-URL', 'Displays the title, description, and link of the original content.'
    def read(url)
        puts "RSS Feed URL: #{url}"
        URI.open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            puts "Title: #{feed.channel.title}"
            puts "Description: #{feed.channel.description}"
            puts "Link: #{feed.channel.link}"
            puts "-"*10
            feed.items.each_with_index do |item, index|
                puts "[#{index}]"
                puts "Item: #{item.title}"
                puts "Link: #{item.link}"
                puts "Description: #{item.description}"
            end
        end
    end

    # TODO: Write a RSS parser from scratch
    # desc 'read RSS-Feed-URL', 'Displays the title, description and link of the original content.'
    # def read(url)
    #     puts "RSS Feed URL: #{url}"
    #     URI.open(url) do |rss|
    #         titles = extract_data('title', rss.read)
    #         descriptions = extract_data('description', rss.read)
    #         links = extract_data('link', rss.read)

    #         items_titles = titles[1..-1]
    #         items_links = links[1..-1]
    #         items_descriptions = descriptions[1..-1]

    #         puts "Title: #{titles[0]}"
    #         puts "Description: #{descriptions[0]}"
    #         puts "Link: #{links[0]}"
    #         puts "-"*10
    #         # items_titles.zip(items_links, items_descriptions).each_with_index do |title, link, description, index|
    #         #     puts "[#{index}]"
    #         #     puts "Title: #{title}"
    #         #     puts "Link: #{link}"
    #         #     puts "Description: #{description}"
    #         # end
    #     end
    # end
end

RSSReaderCli.start(ARGV)