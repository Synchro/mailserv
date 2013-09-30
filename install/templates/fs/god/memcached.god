God.watch do |w|
  w.name = "memcached"
  w.interval = 30.seconds
  w.pid_file = "/var/run/memcached/memcached.pid"
  w.start = "/usr/local/bin/memcached -d -m 64 -a 00777 -u _memcached -P /var/run/memcached/memcached.pid -s /var/run/memcached/memcached.sock"
  w.stop = "kill `cat /var/run/memcached/memcached.pid`"
  w.restart = "kill -HUP `cat /var/run/memcached/memcached.pid`"
  w.start_grace = 20.seconds
  w.restart_grace = 10.seconds

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
