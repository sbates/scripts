#!/usr/bin/env ruby


# You only need to require fileutils when running on really old Ruby
# I wrote this for work on a client running 1.8.5

require 'fileutils'
require 'socket'

app = csf 
srv = Socket.gethostname
file_home = "/etc/#{app}"
local_dir = '/tmp/tmp/#{app}'
remote_srv = "admin.org.com"
remote_dir = "/tmp/sascha/#{app}/#{srv}"
files = [".conf",
        ".allow",
        ".ignore",
        ".pignore",
        "posh.sh"
        ]

# Thse files are root-read-only
# so we make a temp dir where we can move them
# and deal with them as not-root
FileUtils.mkdir_p local_dir

# Check and see if the file exists
# if it does, move it into /tmp
# and give it perms that normal users can use
# Another script comes through later and deletes this dir
files.each do |f|
  foo = "#{file_home}/#{app}#{f}"
  footmp = "#{local_dir}/#{app}#{f}"
  if File.file?(foo)
    FileUtils.cp(foo, local_dir)
    FileUtils.chmod 0666, footmp
  else puts "no file #{foo}"
  end
end
