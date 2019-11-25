#!/usr/bin/env ruby

require "fileutils"

def download(rendering_app, document_type, slug, url)
  filename = File.join("downloads", rendering_app, document_type, "#{slug}.png")
  return if File.exist?(filename)

  FileUtils.mkdir_p(File.dirname(filename))

  puts url
  system("wkhtmltoimage", "-q", "--width", "1280", url, filename)
end

def download_person(slug)
  download("whitehall", "person", slug, "https://www.gov.uk/government/people/#{slug}")
  download("collections", "person", slug, "http://localhost:3070/government/people/#{slug}")
end

def download_role(slug)
  download("whitehall", "role", slug, "https://www.gov.uk/government/ministers/#{slug}")
  download("collections", "role", slug, "http://localhost:3070/government/ministers/#{slug}")
end

person_slugs = File.read("people.txt").split("\n")
role_slugs = File.read("roles.txt").split("\n")

person_slugs.each_slice(500).map do |slice|
  Thread.new do
    slice.each { |slug| download_person(slug) }
  end
end.each(&:join)

role_slugs.each_slice(500).map do |slice|
  Thread.new do
    slice.each { |slug| download_role(slug) }
  end
end.each(&:join)
