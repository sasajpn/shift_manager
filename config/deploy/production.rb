role :app, %w{kazuki@133.130.125.29}
role :web, %w{kazuki@133.130.125.29}
role :db,  %w{kazuki@133.130.125.29}
set :ssh_options, {
  port: '22',
  user: 'kazuki',
  keys: %w{~/.ssh/shifpon_server ~/.ssh/github_rsa},
  forward_agent: true,
  auth_methods: %w{publickey}
}