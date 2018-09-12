current_path = '/var/www/shift_manager/current'
shared_path = '/var/www/shift_manager/shared'

timeout 30

worker_processes 2
working_directory "#{current_path}"

listen "#{shared_path}/tmp/sockets/unicorn.sock"
pid "#{shared_path}/tmp/pids/unicorn.pid"

stderr_path "#{shared_path}/log/unicorn.stderr.log"
stdout_path "#{shared_path}/log/unicorn.stdout.log"

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end