require 'rbvmomi'
require_relative 'vmonkey/version'
require_relative 'vmonkey/vim/vim'

monkey_vim = File.join(File.dirname(__FILE__), 'vmonkey', 'vim')
RbVmomi::VIM.add_extension_dir monkey_vim

module VMonkey
  def self.connect(opts = nil)
    RbVmomi::VIM.monkey_connect(opts)
  end

  def self.default_opts
    RbVmomi::VIM.default_opts
  end
end

module VMonkey
  refine String do
    def parent
      p = self.split('/')[0...-1].join('/')
      p == '' ? '/' : p
    end

    def basename
      p = self.split('/').last
    end
  end
end

class RbVmomi::BasicTypes::ManagedObject
  def monkey
    _connection
  end
end