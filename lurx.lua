local empty = {'literal', nil}

local function literal(ch)
   return {'literal', string.byte(ch)}
end

local function either(r, s)
   return {'either', r, s}
end

local function chain(r, s)
   if r == empty then return s else return {'chain', r, s} end
end

local function star(r)
   return {'star', r}
end

local nullable                  -- forward reference

-- Imagine all strings starting with ch that re matches; return a set
-- of regexes that among them match the remainders of those
-- strings. (For example, if ch is 'c', and re matches 'x', 'ca',
-- 'cat', and 'cow', and [q,r,s] are the keys in the result: that
-- means q|r|s must match 'a', 'at', and 'ow'.)  ch may be nil; in
-- this case return a nonempty set if re matches the empty string.
local function after(ch, re)
   local tag, r, s = re[1], re[2], re[3]
   if tag == 'literal' then
      local result = {}
      if r == ch then result[empty] = true end
      return result
   elseif tag == 'either' then
      local result = after(ch, r)
      for k, _ in pairs(after(ch, s)) do
         result[k] = true
      end
      return result
   elseif tag == 'chain' then
      local result = {}
      for r_rest, _ in pairs(after(ch, r)) do
         result[chain(r_rest, s)] = true
      end
      if nullable(r) then
         for k, _ in pairs(after(ch, s)) do
            result[k] = true
         end
      end
      return result
   elseif tag == 'star' then
      local result = {}
      if ch == nil then
         result[empty] = true
      else
         for r_rest, _ in pairs(after(ch, r)) do
            result[chain(r_rest, re)] = true
         end
      end
      return result
   else
      for k, v in pairs(re) do print(k, v) end
      assert(false)
   end
end

-- Does r match the empty string?
nullable = function(r)
   return after(nil, r)[empty]
end

-- Is any of states nullable?
local function any_nullable(states)
   for state, _ in pairs(states) do
      if nullable(state) then return true end
   end
   return false
end

-- Return the union of after(ch, state) for every state.
local function update(ch, states)
   local result = {}
   for state, _ in pairs(states) do
      for k, _ in pairs(after(ch, state)) do
         result[k] = true
      end
   end
   return result
end

-- Return flag: does regular expression r match a prefix of string str? 
-- If so, return the length of the prefix as a second result.
local function match(r, str)
   if nullable(r) then
      return true, 0
   end
   local states = {}
   states[r] = true
   for i = 1, #str do
      states = update(string.byte(str, i), states)
      if any_nullable(states) then
         return true, i
      end
   end
   return false
end

return {
   empty = empty,
   literal = literal,
   either = either,
   chain = chain,
   star = star,
   match = match,
}
