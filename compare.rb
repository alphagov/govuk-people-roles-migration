#!/usr/bin/env ruby

require "fileutils"

def compare(document_type, slug)
  whitehall_filename = File.join("downloads", "whitehall", document_type, "#{slug}.png")
  collections_filename = File.join("downloads", "collections", document_type, "#{slug}.png")
  return unless File.exist?(whitehall_filename) && File.exist?(collections_filename)

  output_filename = File.join("comparisons", document_type, "#{slug}.png")
  return if File.exist?(output_filename)

  FileUtils.mkdir_p(File.dirname(output_filename))

  puts output_filename
  system(
    "blink-diff",
    "--output", output_filename,
    "--h-shift", "50",
    "--v-shift", "50",
    whitehall_filename,
    collections_filename
  )
end

person_slugs = File.read("people.txt").split("\n")
role_slugs = File.read("roles.txt").split("\n")

person_slugs.each_slice(500).map do |slice|
  Thread.new do
    slice.each { |slug| compare("person", slug) }
  end
end.each(&:join)

role_slugs.each_slice(500).map do |slice|
  Thread.new do
    slice.each { |slug| compare("role", slug) }
  end
end.each(&:join)
