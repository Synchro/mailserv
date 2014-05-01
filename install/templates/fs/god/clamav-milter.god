God.watch do |w|
  w.name = "clamav-milter"
  w.interval = 30.seconds # default
  w.start = "/etc/rc.d/clamav_milter start"
  w.stop = "/etc/rc.d/clamav_milter stop"
  w.restart = "/etc/rc.d/clamav_milter restart"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/clamd/clamav-milter.pid"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
