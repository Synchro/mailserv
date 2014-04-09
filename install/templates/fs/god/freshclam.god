God.watch do |w|
  w.name = "freshclam"
  w.interval = 1.hours
  w.pid_file = "/var/run/freshclam.pid"
  w.start = "/etc/rc.d/freshclam start"
  w.stop = "/etc/rc.d/freshclam stop"
  w.restart = "/etc/rc.d/freshclam restart"
  w.start_grace = 30.seconds
  w.restart_grace = 30.seconds

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 30.seconds
      c.running = false
    end
  end
end
