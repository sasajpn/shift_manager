role :app, %w{kazuki@133.130.125.29}
role :web, %w{kazuki@133.130.125.29}
role :db,  %w{kazuki@133.130.125.29}
set :ssh_options, {
  port: 22,
  keys: File.expand_path('~/.ssh/shifpon_server'),
}