#!/usr/bin/env ruby
require 'fileutils'
require 'tempfile'
require 'open3'

# Check for version argument
if ARGV.empty?
  puts "Usage: ruby update_formula.rb VERSION"
  puts "Example: ruby update_formula.rb 0.3.8"
  exit 1
end

new_version = ARGV[0]
formula_file = "pairstair.rb"
temp_dir = Dir.mktmpdir
platforms = ["darwin-arm64", "darwin-amd64", "linux-arm64", "linux-amd64"]

puts "Updating formula to version #{new_version}"
puts "Temporary directory: #{temp_dir}"

# Read the formula file
formula_content = File.read(formula_file)

# Update version
formula_content.gsub!(/version "[0-9.]*"/, "version \"#{new_version}\"")

# Function to download file using curl and calculate SHA256
def download_and_calculate_sha256(url, output_path)
  puts "Downloading #{url}"

  # Use curl with -L to follow redirects
  curl_command = ["curl", "-L", "-s", "-o", output_path, url]
  download_output, download_status = Open3.capture2e(*curl_command)

  if download_status.success?
    # Calculate SHA256 using shasum
    sha_command = ["shasum", "-a", "256", output_path]
    sha_output, sha_status = Open3.capture2(*sha_command)

    if sha_status.success?
      sha256 = sha_output.split.first
      puts "SHA256: #{sha256}"
      return sha256
    else
      puts "Error calculating SHA256: #{sha_output}"
      return nil
    end
  else
    puts "Error downloading file: #{download_output}"
    return nil
  end
end

# Update binaries with a simple approach
formula_lines = formula_content.lines

platforms.each do |platform|
  # Update URL for this platform
  new_url = "url \"https://github.com/gypsydave5/pairstair/releases/download/v#{new_version}/pairstair-#{platform}\""

  # Find the appropriate section
  platform_index = formula_lines.find_index { |line| line.include?(platform) }

  if platform_index
    # Update URL
    url_index = platform_index
    if formula_lines[url_index].include?("url")
      formula_lines[url_index] = "      #{new_url}\n"
    end

    # Download and calculate SHA256
    download_url = "https://github.com/gypsydave5/pairstair/releases/download/v#{new_version}/pairstair-#{platform}"
    output_path = File.join(temp_dir, "pairstair-#{platform}")

    if sha256 = download_and_calculate_sha256(download_url, output_path)
      # Update SHA256
      sha_index = platform_index + 1
      if formula_lines[sha_index].include?("sha256")
        formula_lines[sha_index] = "      sha256 \"#{sha256}\"\n"
        puts "Updated SHA256 for #{platform}"
      end
    end
  end
end

# Update man page
man_url_index = formula_lines.find_index { |line| line.include?("pairstair.1") }

if man_url_index
  # Update URL
  formula_lines[man_url_index] = "    url \"https://github.com/gypsydave5/pairstair/releases/download/v#{new_version}/pairstair.1\"\n"

  # Download and calculate SHA256
  man_download_url = "https://github.com/gypsydave5/pairstair/releases/download/v#{new_version}/pairstair.1"
  man_output_path = File.join(temp_dir, "pairstair.1")

  if man_sha256 = download_and_calculate_sha256(man_download_url, man_output_path)
    # Update SHA256
    man_sha_index = man_url_index + 1
    if formula_lines[man_sha_index].include?("sha256")
      formula_lines[man_sha_index] = "    sha256 \"#{man_sha256}\"\n"
      puts "Updated SHA256 for man page"
    end
  end
end

# Write updated formula back to file
File.write(formula_file, formula_lines.join)

# Clean up
FileUtils.remove_entry(temp_dir)

puts "Formula updated successfully!"
puts "To verify all checksums are correct, run: brew fetch --force #{formula_file}"
puts "To test the formula, run: brew install --build-from-source ./#{formula_file}"
