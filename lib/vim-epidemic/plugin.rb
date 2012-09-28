require 'uri'

module VimEpidemic

  class Plugin

    def initialize config, *args, block
      @config = config
      options = args.last.kind_of?(Hash) ? args.pop : {}
      @source = args.shift
      @type = args.shift || options[:type]
      @block = block
    end

    def install
      if File.exists? dir
        Dir.chdir dir
        `git pull`
      else
        Dir.chdir @config.bundle_dir
        `git clone #{complete_source} #{name}`
      end
      $? == 0
    end

    def to_s
      Paint["#{name} (#{complete_source})", installed? ? :green : :yellow]
    end

    def installed?
      File.exists? dir
    end

    private

    def dir
      File.join @config.bundle_dir, name
    end

    def name
      complete_source.sub(/.*\//, '').sub(/\.git\Z/, '')
    end

    def complete_source
      if @source.match /\Agit\:\/\//
        @source
      else
        "git://github.com/#{@source}.git"
      end
    end
  end
end
