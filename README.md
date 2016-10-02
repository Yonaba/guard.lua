guard.lua
=====

[![Build Status](https://travis-ci.org/Yonaba/guard.lua.png)](https://travis-ci.org/Yonaba/guard.lua)
[![Coverage Status](https://coveralls.io/repos/Yonaba/guard.lua/badge.png?branch=master)](https://coveralls.io/r/Yonaba/guard.lua?branch=master)
[![Lua](https://img.shields.io/badge/Lua-5.1%2C%205.2%2C%205.3%2C%20JIT-blue.svg)]()
[![License](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)

Minimalistic library providing Elixir-style guards for Lua.

## Download and Install

#### Archive

Current release is [0.0.1](https://github.com/Yonaba/guard.lua/releases/tag/guard.lua-0.0.1-1). See other [releases](https://github.com/Yonaba/guard.lua/releases).

#### Bash

This will clone the repository, as-is, and deliver the cutting edge release. Might be unstable.

```
git clone git://github.com/Yonaba/guard.lua.git
```

#### LuaRocks

This will download and install the latest stable release from [Luarocks](https://luarocks.org/) servers.

````
luarocks install guard
````

## Documentation

Find the project page at [yonaba.github.io/guard.lua](gttp://yonaba.github.io/guard.lua).  
A full documentation is available on the [wiki](https://github.com/Yonaba/guard.lua/wiki).

##Specification

You can run the included specs with [Telescope](https://github.com/norman/telescope) using the following command from Lua from the root foolder:

```
lua tsc -f specs/*
```

##License

This work is [MIT-Licensed](https://raw.githubusercontent.com/Yonaba/30log/master/LICENSE).

