#!/usr/bin/env ruby

require 'rubygems'
require 'aws-sdk'

stack_name = ARGV.shift

stack_name = case stack_name
when 'prod'
  'Rails Production - Misc'
when 'stage'
  'Rails Staging'
else
  stack_name
end

AWS.config({
  :access_key_id => ENV['AWS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_KEY'],
})

opsworks = AWS::OpsWorks.new
c = opsworks.client
stacks = c.describe_stacks[:stacks]

stack = stacks.detect {|s| s[:name].downcase == stack_name.downcase}

instances = c.describe_instances(stack_id: stack[:stack_id])[:instances]
instance = instances.detect {|i| i[:status] == 'online'}

puts instance[:private_ip]
