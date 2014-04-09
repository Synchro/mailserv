God.watch do |w|
  w.name = "php"
  w.interval = 30.seconds 
  w.pid_file = "/var/run/php-fpm.pid"
  w.start = "/etc/rc.d/php_fpm start"
  w.stop = "/etc/rc.d/php_fpm stop"
  w.restart = "/etc/rc.d/php_fpm restart"
  w.start_grace = 20.seconds
  w.restart_grace = 10.seconds

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end
