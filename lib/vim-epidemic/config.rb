
module VimEpidemic

  class Config
    attr_reader :plugins

    def initialize
      @plugins = []
      @home = File.expand_path '~'
    end

    def touch
      FileUtils.touch file
    end

    def has? *args
      @plugins.find{ |p| p.match? *args }
    end

    def empty?
      @plugins.empty?
    end

    def install *args, &block
      @plugins << Plugin.new(self, *args, block)
    end

    def configure &block
      self.instance_eval &block
    end

    def file
      File.join @home, '.epidemic.vim.rb'
    end

    def exists?
      File.exists? file
    end

    def bundle_dir
      File.join @home, '.vim', 'bundle'
    end
  end
end
