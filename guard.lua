local setmetatable = setmetatable
local ipairs       = ipairs
local error        = error
local assert       = assert

local _guardian = function ()
	local guard = {__when = {}}
	
	guard.when = function(filter, f)
		assert(type(filter) == 'function', 'Wrong argument #1 to when(). Expected a function')	
		assert(type(f) == 'function', 'Wrong argument #2 to when(). Expected a function')	
		guard.__when[#guard.__when + 1] = {filter = filter, f = f}
		return guard
	end
	
	guard.any = function(f)
		assert(type(f) == 'function', 'Wrong argument to any(), Expected a function')
		guard.__any = f
		return guard
	end
	
	return setmetatable(guard,{__call = function(guard, ...)
		for k, g in ipairs(guard.__when) do
			if g.filter(...) then 
				return g.f(...) 
			end
		end
		if guard.__any then 
			return guard.__any(...) 
		end
		return error(("No guard defined for given arguments"),1)
	end})
end

return setmetatable({
	_DESCRIPTION = 'Elixir-style guards for Lua',
	_VERSION     = 'guard v0.0.1',
	_URL         = 'http://github.com/Yonaba/guard.lua',
	_LICENSE     = 'MIT LICENSE <http://www.opensource.org/licenses/mit-license.php>'
},{__call = function() return _guardian() end})