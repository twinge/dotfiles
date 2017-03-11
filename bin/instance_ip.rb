#!/usr/bin/env ruby

require 'rubygems'
require 'json'

app_name = ARGV.shift

if app_name.include?('.')
  # ip address
  puts app_name
else
  cluster = app_name.include?('stag') ? 'stage' : 'prod'

  service = JSON.parse(`aws ecs describe-services --cluster #{cluster} --services #{app_name}`)['services'].first

  service_arn = service['serviceArn']

  tasks = JSON.parse(`aws ecs list-tasks --service-name #{service_arn} --cluster #{cluster}`)['taskArns']

  task_hash = tasks.first.split('/').last

  task_desc = JSON.parse(`aws ecs describe-tasks --tasks #{task_hash} --cluster #{cluster}`)

  c_instance_hash = task_desc['tasks'].first['containerInstanceArn'].split('/').last

  c_instances = JSON.parse(`aws ecs describe-container-instances --container-instances #{c_instance_hash} --cluster #{cluster}`)

  instance_id = c_instances['containerInstances'].first['ec2InstanceId']

  instances = JSON.parse(`aws ec2 describe-instances --instance-ids #{instance_id}`)

  puts instances['Reservations'].first['Instances'].first['PrivateIpAddress']
end
