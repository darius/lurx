local accepts = {}

local function label(accepting, state)
   if (accepting) then
      accepts[state] = true
   else
      assert(not accepts[state])
   end
   return state
end

local accept = label(true, function(ch, bound) return {} end)

local function union(states1, states2)
   local result = {}            -- XXX ok to clobber states1 instead?
   for k, _ in pairs(states1) do
      result[k] = true         
   end
   for k, _ in pairs(states2) do
      result[k] = true         
   end
   return result
end

local function after(ch, start, bound)
   if start == bound then       -- XXX is there an identity test instead?
      return {}
   else
      return start(ch, bound)
   end
end

local function lit(char, k)
   local function act(ch, bound)
      local result = {}
      if char == ch then result[k] = true end
      return result
   end
   return label(false, act)
end

local function alt(k1, k2)
   local function act(ch, bound)
      return union(after(ch, k1, bound), after(ch, k2, bound))
   end
   return label(accepts[k1] or accepts[k2], act)
end

local function star(r)
   return function(k)
      local body, loop
      local function act(ch, bound)
         return union(after(ch, body, loop),
                      after(ch, k, bound))
      end
      loop = label(accepts[k], act)
      body = r(loop)
      return loop
   end
end

local function empty(k)
   return k
end

local function literal(ch)
   local byte = string.byte(ch)
   return function(k) return lit(byte, k) end
end

local function either(r, s)
   return function(k) return alt(r(k), s(k)) end
end

local function chain(r, s)
   return function(k) return r(s(k)) end
end

-- Is any of states accepting?
local function any_accepts(states)
   for state, _ in pairs(states) do
      if accepts[state] then return true end
   end
   return false
end

-- Return the union of after(ch, state) for every state.
local function update(ch, states)
   local result = {}
   for state, _ in pairs(states) do
      for k, _ in pairs(after(ch, state, accept)) do
         result[k] = true
      end
   end
   return result
end

local function run(start, str)
   if accepts[start] then
      return true, 0
   end
   local states = {}
   states[start] = true
   for i = 1, #str do
      states = update(string.byte(str, i), states)
      if any_accepts(states) then
         return true, i
      end
   end
   return false
end

-- Return flag: does regular expression r match a prefix of string str? 
-- If so, return the length of the prefix as a second result.
local function match(re, str)
   return run(re(accept), str)
end

return {
   empty = empty,
   literal = literal,
   either = either,
   chain = chain,
   star = star,
   match = match,
}
