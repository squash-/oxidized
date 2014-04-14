module Oxidized
  require 'asetus'
  class Config
    Root      = File.join ENV['HOME'], '.config', 'oxidized'
    Crash     = File.join Root, 'crash'
    InputDir  = File.join Directory, %w(lib oxidized input)
    OutputDir = File.join Directory, %w(lib oxidized output)
    ModelDir  = File.join Directory, %w(lib oxidized model)
    SourceDir = File.join Directory, %w(lib oxidized source)
    Sleep     = 1
  end
  class << self
    attr_accessor :mgr
  end
  CFGS = Asetus.new :name=>'oxidized', :load=>false, :key_to_s=>true
  CFGS.default.username = 'username'
  CFGS.default.password = 'password'
  CFGS.default.model    = 'junos'
  CFGS.default.interval = 3600
  CFGS.default.log      = File.join Config::Root, 'log'
  CFGS.default.debug    = false
  CFGS.default.threads  = 30
  CFGS.default.timeout  = 30
  CFGS.default.prompt   = /^([\w.@-]+[#>]\s?)$/
  CFGS.default.rest     = '0.0.0.0:8888'  # or false to disable
  CFGS.default.vars     = {}              # could be 'enable'=>'enablePW'

  CFGS.default.input.default = 'ssh, telnet'
  CFGS.default.input.ssh.secure = false

  CFGS.default.output.default = 'git'
  CFGS.default.source.default = 'csv'

  CFGS.default.model_map = {
    'cisco'   => 'ios',
    'juniper' => 'junos',
  }

  CFGS.load       # load system+user configs, merge to Config.cfg
  CFG = CFGS.cfg  # convenienence, instead of Config.cfg.password, CFG.password

  Log.level = Logger::INFO unless CFG.debug
  Log.file  = CFG.log if CFG.log
end
