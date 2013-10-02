local lurx = require 'lurx'

local match   = lurx.match

local empty   = lurx.empty
local literal = lurx.literal
local either  = lurx.either
local chain   = lurx.chain
local star    = lurx.star

local function repeated(n, re)
   local result = lurx.empty
   for i = 1, n do
      result = chain(re, result)
   end
   return result
end

local function make_re(n)
   local a = literal('a')
   return repeated(n, either(a, chain(a, a)))
end

local function benchmark(times, n, length)
   local re = make_re(n)
   local nope1 = string.rep('ab', length)
   local nope2 = string.rep('a', length-1) .. 'b'
   local yep = string.rep('a', length)
   local started = os.clock()
   for i = 1, times do
      assert(not match(re, nope1))
      assert(not match(re, nope2))
      assert(match(re, yep))
   end
   local ended = os.clock()
   return ended - started
end

print(benchmark(10, 100, 100))

return benchmark
