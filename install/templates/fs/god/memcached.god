God.watch do |w|
  w.name = "memcached"
  w.interval = 30.seconds
  w.pid_file = "/var/run/memcached/memcached.pid"
  w.start = "/etc/rc.d/memcached start"
  w.stop = "/etc/rc.d/memcached stop"
  w.restart = "/etc/rc.d/memcached restart"
  w.start_grace = 20.seconds
  w.restart_grace = 10.seconds

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
