God.watch do |w|
  w.name = "freshclam"
  w.interval = 1.hours
  w.pid_file = "/var/run/freshclam.pid"
  w.start = "/usr/local/bin/freshclam --daemon --no-warnings"
  w.stop = "kill `cat /var/run/freshclam.pid`"
  w.restart = "kill `cat /var/run/freshclam.pid` && sleep 3 && /usr/local/bin/freshclam --daemon --no-warnings"
  w.start_grace = 30.seconds
  w.restart_grace = 30.seconds

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 30.seconds
      c.running = false
    end
  end
end
