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

      @run_as_daemon  = options.fetch(:daemonize, false)
      @enable_bundler = options.fetch(:bundler, true) 
      @config_file    = options.fetch(:config_file, File.join("config", "unicorn.rb"))
      @pid_file       = options.fetch(:pid_file, File.join("tmp", "pids", "unicorn.pid"))

      if File.exist? @config_file
        @config_path = @config_file
      end

      super
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
      # Make sure unicorn is stopped
      stop

      cmd = [] 
      cmd << "bundle exec" if use_bundler?
      cmd << "unicorn_rails"
      cmd << "-c #{@config_path}" if use_config_file?
      cmd << "-D" if daemonize? 

      @pid = Process.fork do
        system "#{cmd.join " "}"
      end

      success "Unicorn started."
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
      return unless pid

      begin
        Process.kill("QUIT", pid) if Process.getpgid(pid) 

        # Unicorn won't always shut down right away, so we're waiting for
        # the getpgid method to raise an Errno::ESRCH that will tell us
        # the process is not longer active.
        sleep 1 while Process.getpgid(pid)
        success "Unicorn stopped."
      rescue Errno::ESRCH
        # Don't do anything, the process does not exist
      end
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
      Process.kill "HUP", pid

      success "Unicorn reloaded"
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
      reload
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
      reload
    end

    private
    def pid
      # Favor the pid in the pidfile, since some processes
      # might daemonize properly and fork twice.
      if File.exists?(@pid_file)
        @pid = File.open(@pid_file) { |f| f.gets.to_i } 
      end

      @pid
    end

    def info(msg)
      UI.info(msg)
    end

    def pending message
      notify message, :image => :pending
    end

    def success message
      notify message, :image => :success
    end

    def failed message
      notify message, :image => :failed
    end

    def notify(message, options = {})
      Notifier.notify(message, options)
    end

    def daemonize?
      @run_as_daemon
    end

    def use_bundler?
      @enable_bundler
    end

    def use_config_file?
      File.exist? @config_path
    end
  end
end
