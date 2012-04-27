#!/usr/bin/env ruby
unless ARGV[0]
  puts "Bad environment argument (use 'p' or 's')"
  exit
end
case ARGV[0]
when 's'
  env = 'staging'
when 'p'
  env = 'production'
else
  env = 'staging'
  if ARGV[1]
    puts "Bad environment argument (use 'p' or 's')"
    exit
  else
    app = ARGV[0]
    branch = ARGV[1]
  end
end
app ||= ARGV[1]
branch ||= ARGV[2]

unless app
  puts "You have to specify which app you'd like to deploy" 
  exit
end

cmd = "bundle exec cap #{app}:#{env} deploy"
if branch
  cmd += " branch=#{branch}"
end
`#{cmd}`