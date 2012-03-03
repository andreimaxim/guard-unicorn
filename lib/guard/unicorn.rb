require 'guard'
require 'guard/guard'

require 'guard/unicorn/version'

module Guard
  class Unicorn < Guard

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      if watchers.empty?
        watchers << Watcher.new( /^app\/(controllers|models|helpers)\/.+\.rb$/ )
        watchers << Watcher.new( /^lib\/.+\.rb$/ )
      end

      @run_as_daemon = options.fetch(:daemonize, false)

      @pid_path    = File.join("tmp", "pids", "unicorn.pid")
      @config_path = File.join("config", "unicorn.rb")

      super
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
      info "Starting Unicorn..."
      start_unicorn
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
      info "Stopping Unicorn"
      stop_unicorn
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
      info "Reloading Unicorn"
      restart_unicorn
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      restart_unicorn
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
    end

    private
    def start_unicorn
      # Make sure unicorn is stopped
      stop_unicorn

      cmd = [] 
      cmd << "unicorn_rails"
      cmd << "-c #{@config_path}"
      cmd << "-D" if daemonize? 

      @pid = Process.fork do
        system "#{cmd.join " "}"
        info "Unicorn started."
      end
    end

    def restart_unicorn
      Process.kill "HUP", pid
    end

    def stop_unicorn
      return unless pid

      begin
        Process.kill("QUIT", pid) if Process.getpgid(pid) 

        # Unicorn won't always shut down right away, so we're waiting for
        # the getpgid method to raise an Errno::ESRCH that will tell us
        # the process is not longer active.
        sleep 1 while Process.getpgid(pid)
      rescue Errno::ESRCH
        # Don't do anything, the process does not exist
      end
    end

    def pid
      # Favor the pid in the pidfile, since some processes
      # might daemonize properly and fork twice.
      if File.exists?(@pid_path)
        @pid = File.open(@pid_path) { |f| f.gets.to_i } 
      end

      @pid
    end

    def info(msg)
      UI.info(msg)
    end

    def daemonize?
      @run_as_daemon
    end
  end
end
