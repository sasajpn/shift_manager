role :app, %w{kazuki@133.130.125.29}
role :web, %w{kazuki@133.130.125.29}
role :db,  %w{kazuki@133.130.125.29}
set :ssh_options, {
  port: '22',
  user: 'kazuki',
  keys: File.expand_path('~/.ssh/shifpon_server'),
  forward_agent: true,
  auth_methods: %w{publickey}
}