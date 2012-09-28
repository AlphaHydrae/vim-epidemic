
module VimEpidemic

  class Config
    attr_reader :plugins

    def initialize
      @plugins = []
      @home = File.expand_path '~'
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
