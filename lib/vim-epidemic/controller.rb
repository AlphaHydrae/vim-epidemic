
module VimEpidemic

  class Controller

    def initialize
      @config = Config.new
    end

    def info options = {}
      load_config!
      puts "\n#{banner}\n\n"
      if @config.plugins.any?
        @config.plugins.each do |plugin|
          puts "   #{plugin}"
        end
      else
        puts "No plugins installed."
      end
      puts
    end

    def update options = {}
      check_requirements!
      load_config!
      puts "\n#{banner}\n"
      successful = true
      @config.plugins.each do |plugin|
        puts
        action = plugin.installed? ? 'Updating' : 'Installing'
        puts Paint["#{action} #{plugin}...", :yellow]
        if plugin.install
          puts Paint["Done!", :green]
        else
          successful = false
          puts Paint["Could not install.", :red]
        end
      end
      puts
      if successful
        puts Paint["All plugins were successfully installed/updated.", :green, :bold]
      else
        puts Paint["There were problems with some of the plugins.", :red, :bold]
      end
      puts
    end

    private

    def banner
      String.new.tap do |s|
        s << Paint[%|epidemic.vim v#{VERSION}|, :bold]
        s << %|\nconfiguration: |
        if @config.exists?
          s << @config.file
        else
          s << %|none (create one by running "vim-epidemic config")|
        end
        s << "\nbundles: #{@config.bundle_dir}"
      end
    end

    def check_requirements!
      abort %|epidemic.vim requires "git" to be in your $PATH| unless Which.which('git')
    end

    def abort msg
      warn Paint[msg, :red]
      exit 1
    end

    def load_config!
      @config.instance_eval read_config, @config.file if @config.exists?
    end

    def read_config
      File.open(@config.file, 'r').read
    end
  end
end
