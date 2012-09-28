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

    def match? *args
      complete_source(args.first) == complete_source
    end

    def install
      if File.exists? dir
        Dir.chdir dir
        `git pull`
      else
        Dir.chdir @config.bundle_dir
        `git clone #{complete_source} #{name}`
        Dir.chdir dir if $? == 0
      end
      call_block if $? == 0
      $? == 0
    end

    def to_s
      "#{name} (#{complete_source})"
    end

    def installed?
      File.exists? dir
    end

    private

    def call_block
      @block.call if @block
    end

    def dir
      File.join @config.bundle_dir, name
    end

    def name
      complete_source.sub(/.*\//, '').sub(/\.git\Z/, '')
    end

    def complete_source source = @source
      if source.match /\Agit\:\/\//
        source
      else
        "git://github.com/#{source}.git"
      end
    end
  end
end
