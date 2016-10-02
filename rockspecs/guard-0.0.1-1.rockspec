package = "guard"
version = "0.0.1-1"
source = {
   url = "https://github.com/Yonaba/guard.lua/archive/guard.lua-0.0.1-1.tar.gz",
   dir = "guard.lua-guard.lua-0.0.1-1"
}
description = {
  summary = "Elixir-style guards for Lua",
  detailed = [[Lua library providing Elixir-style guards for Lua.]],
  homepage = "http://yonaba.github.io/guard.lua",
  license = "MIT <http://www.opensource.org/licenses/mit-license.php>"
}
dependencies = {"lua >= 5.1, <=5.3"}
build = {
  type = "builtin",
  modules = {
    ["guard"] = "guard.lua",
  }
}