
module VimEpidemic

  class Controller

    def initialize
      @config = Config.new
    end

    def info options = {}
      load_config!
      show_info
    end

    def update options = {}
      check_requirements!
      load_config!
      puts "\n#{banner}\n"
      if @config.empty?
        puts "\nNothing to update.\n\n"
        exit 0
      end
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

    def add args, options = {}
      load_config!
      unless @config.has? *args
        @config.touch unless @config.exists?
        File.open(@config.file, 'a') do |f|
          f.write %|\ninstall "#{args.first}"|
        end
        @config.install *args
      end
      show_info
    end

    private

    def show_info
      puts "\n#{banner}\n\n"
      if @config.plugins.any?
        @config.plugins.each do |plugin|
          puts "   #{Paint[plugin.to_s, plugin.installed? ? :green : :yellow]}"
        end
      else
        puts Paint[%|No plugins registered.|, :yellow]
        puts %|Run "vim-epidemic add <REPO>" to register one.|
      end
      puts
    end

    def banner
      String.new.tap do |s|
        s << Paint[%|epidemic.vim v#{VERSION}|, :bold]
        s << %|\nconfiguration: |
        if @config.exists?
          s << @config.file
        else
          s << %|none|
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
