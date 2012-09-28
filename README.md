# epidemic.vim

Downloads vim plugins and installs them into the pathogen.vim bundle directory.

    # list installed plugins
    vim-epidemic

    # register plugins from git repositories (on GitHub by default)
    vim-epidemic add tpope/vim-fugitive
    vim-epidemic add git://github.com/tpope/vim-rails.git

    # install/update registered plugins
    vim-epidemic update

**v0.0.4: at the moment, epidemic.vim only supports plugins in the form of git repositories.**

## Requirements

The `git` command must be available in the PATH.

## Installation

    gem install vim-epidemic

## Usage

Add plugin repositories with `vim-epidemic add <REPO>` (see <a href="#configuration">Configuration</a>).

Install/update all registered plugins with `vim-epidemic update`. New plugin repositories will be cloned into `.vim/bundle`; existing ones will be updated with `git pull`.

The repositories must be publicly accessible.

<a name="configuration"></a>
## Configuration

epidemic.vim looks for `~/.epidemic.vim.rb` by default. This file is automatically created when you use the `add` command.

### Register Plugins

A plugin from a git repository can be added from the command line like this:

    vim-epidemic add git://github.com/tpope/vim-rails.git

For GitHub repositories, the `username/repo` part is sufficient:

    vim-epidemic add tpope/vim-fugitive

Or you can manually edit the configuration file:

```ruby
install "tpope/vim-fugitive"
install "git://github.com/tpope/vim-rails.git"
```

## License (MIT)

Copyright (c) 2011 Alpha Hydrae

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
