#!/usr/bin/ruby 

# World's simplest connection test script

require 'socket'
require 'timeout'

def listening?(ip, port, seconds=2)
  Timeout::timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
     rescue => e
     $stdout.print e.inspect + "........"
    end
  end
rescue Timeout::Error => tout
  $stdout.print tout.inspect + "........"
end
servs = [
	"server1.org.com",
	"server2.org.com",
	"server3.org.com"
	]

servs.each do |serv|
  ports = [22]
  ports.each do |port|
    if listening?(serv, port)
      puts "#{serv} is listening on #{port}"
    else
      puts "#{serv} is NOT listening on #{port}"
    end
  end
end
