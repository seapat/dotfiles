# defined this right above $env.config, can be done wherever
def show_banner [] {
  let ellie = [
    "     __  , ",
    " .--()°'.' ",
    "'|, . ,'   ",
    " !_-(_\\    ",
  ]
  # let s = (sys)
  print $"(ansi green)($ellie.0)  (ansi yellow)🐘 (ansi yellow_bold)Nushell \t (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
  print $"(ansi reset)(ansi green)($ellie.1)"
  # FIXME: startup-time always show -1ns
  print $"(ansi green)($ellie.2)  (ansi light_blue)⌚ (ansi light_blue_bold)Startup \t (ansi reset)(ansi light_blue)($nu.startup-time)(ansi reset)"
  print $"(ansi green)($ellie.3)  (ansi light_purple)💻 (ansi light_purple_bold)Uptime \t (ansi reset)(ansi light_purple)(sys.host.uptime)(ansi reset)"
  print $""
} 
show_banner 