require 'luacov'
local guard = require('guard')
local env = _ENV and _ENV or _G

context('require ("guard")', function()
	
	test('returns the guard module', function()
		assert_type(guard, 'table')
	end)
	
	test('it does not pollute the global environment', function()
		assert_nil(env.guard)
	end)	
	
	test('the module can be called as a function', function()
		assert_not_error(guard)
	end)	
	
	test('it has a _DESCRIPTION', function()
		assert_type(guard._DESCRIPTION, 'string')
	end)
	
	test('it has a _VERSION', function()
		assert_type(guard._VERSION, 'string')
	end)

	test('it has an _URL', function()
		assert_type(guard._URL, 'string')
	end)	
	
	test('it has a _LICENSE', function()
		assert_type(guard._LICENSE, 'string')
	end)
	
end)

context('Guards', function()
	
	local g
	
	before(function()
		g = guard()
	end)
	
	test('can be empty', function()
		assert_type(g, 'table')
	end)
	
	test('but in that case, calling them raises an error', function()
		assert_error(g)
	end)
	
	test('implements when() clause', function()
		assert_type(g.when, 'function')
	end)	
	
	test('and also a any() clause', function()
		assert_type(g.any, 'function')
	end)	

end)

context('The any() clause', function()

	local g, f, f2
	
	before(function()
		f = function() return 'default' end
		f2 = function() return 'new_any' end
		g = guard().any(f)			
	end)

	test('any() expects one function argument', function()
		assert_error(function()  guard().any() end)
		assert_error(function()  guard().any({}) end)
		assert_error(function()  guard().any('') end)
		assert_not_error(function()  guard().any(function() end) end)
	end)	
	
	test('when being the only clause provided, it is always evaluated', function()
		assert_equal(g(), 'default')
	end)
	
	test('there can be one single any clause', function()
		g.any(f2)
		assert_equal(g(), 'new_any')
	end)
	
end)

context('The when() clause', function()

	local g
	local isOdd, doubleIfOdd
	
	before(function()
		isOdd = function(n) return n%2 ~= 0 end
		doubleIfOdd = function(n) return n * 2 end
		g = guard().when(isOdd, doubleIfOdd)			
	end)
	
	test('when() expects two function arguments', function()
		assert_error(function()  guard().when() end)
		assert_error(function()  guard().when('',nil) end)
		assert_error(function()  guard().when(nil, {}) end)
		assert_error(function()  guard().when('', {}) end)
		assert_error(function()  guard().when(function() end, {}) end)
		assert_error(function()  guard().when('', function() end) end)
		assert_not_error(function() guard().when(function() end, function() end) end)
	end)
		

	test('it executes the clause when filter evaluates to true', function()
		assert_equal(g(3), 6)
	end)
	
	test('it raises a error in case the argument does not pass the filter', function()
		assert_error(function() g(2) end)
	end)
	
	test('unless a any clause was defined', function()
		g.any(function() return 'default case' end)
		assert_equal(g(2), 'default case')
	end)
	
end)

context('For a chain of when() clauses', function()
	
	local truthy, falsy
	local f_one, f_two, f_three, f_four
	local g, h
	
	before(function()
		truthy = function() return true end
		falsy = function() return false end
		
		f_one = function() return 1 end
		f_two = function() return 2 end
		f_three = function() return 3 end
		f_four = function() return 4 end
		
		g = guard()
					.when(falsy, f_one)
					.when(truthy, f_two)
					.when(falsy, f_three)
					.when(truthy, f_four)
					
		h = guard()
					.when(falsy, f_one)
					.when(falsy, f_two)
					.when(falsy, f_three)				
	end)
	
	test('the first truthy clause will be evaluated', function()
		assert_equal(g(), 2)
	end)
	
	test('falsy ones will be ignored', function()
		assert_not_equal(g(), 1)
		assert_not_equal(g(), 3)
	end)
	
	test('evaluation is FIFO, so only the first truthy clause is examined', function()
		assert_not_equal(g(), 4)		
		
	end)
	
	test('if all when clauses fail, an error is raised', function()
		assert_error(h)		
	end)

	test('unless a any() clause is provided', function()
		h.any(f_four)
		assert_equal(h(), 4)		
	end)		

end)
