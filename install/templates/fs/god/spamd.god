God.watch do |w|
  w.name = "spamd"
  w.group = "mailserv"
  w.interval = 30.seconds # default
  w.start = "/etc/rc.d/spamd start"
  w.stop = "/etc/rc.d/spamd stop"
  w.restart = "/etc/rc.d/spamd restart"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/spamd.pid"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
