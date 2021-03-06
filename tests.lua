local lurx = require 'lurx'

local literal = lurx.literal
local either  = lurx.either
local chain   = lurx.chain
local star    = lurx.star

local function rx_test(input, expected_remainder, pattern)
   local result, match_length = lurx.match(pattern, input)
   if result ~= (expected_remainder ~= nil) then
      print('Wrong result for', input, expected_remainder, pattern)
   elseif result and match_length + #expected_remainder ~= #input then
      print('Wrong remainder for', input, expected_remainder, pattern)
   end
end

rx_test('', nil, literal('X'))
rx_test('wheee', nil, literal('X'))
rx_test('X', '', literal('X'))
rx_test('XXXee', 'XXee', literal('X'))
rx_test('yX', nil, literal('X'))
rx_test('yX', nil, either(literal('X'), literal('X')))
rx_test('YX', nil, either(literal('X'), chain(literal('Y'), literal('Y'))))
rx_test('Xy', 'y', either(literal('X'), literal('X')))
rx_test('XYY', 'YY', either(literal('X'), chain(literal('Y'), literal('Y'))))
rx_test('alloha', 'lloha', either(chain(literal('a'), chain(literal('l'), chain(literal('l'), literal('o')))), literal('a')))
rx_test('aab', nil, chain(literal('a'), literal('b')))
rx_test('aba', 'a', chain(literal('a'), literal('b')))
rx_test('cats are fat', 's are fat', either(chain(literal('r'), chain(literal('a'), literal('t'))), chain(literal('c'), chain(literal('a'), literal('t')))))
rx_test('XX', nil, chain(literal('X'), chain(literal('X'), literal('X'))))
rx_test('XXXish?', nil, chain(literal('X'), chain(literal('X'), chain(literal('X'), literal('Y')))))
rx_test('XXXY?', '?', chain(literal('X'), chain(literal('X'), chain(literal('X'), literal('Y')))))
rx_test('bababyish', 'ish', chain(literal('b'), chain(literal('a'), chain(literal('b'), chain(literal('a'), chain(literal('b'), literal('y')))))))
rx_test('babababyish', nil, chain(literal('b'), chain(literal('a'), chain(literal('b'), chain(literal('a'), chain(literal('b'), literal('y')))))))
rx_test('01100011000110001100 how are you?', ' how are you?', chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), either(literal('0'), literal('1'))))))))))))))))))))))
rx_test('0110001100011000110 how are you?', nil, chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), chain(either(literal('0'), literal('1')), either(literal('0'), literal('1'))))))))))))))))))))))
rx_test('aaa b', 'a b', chain(either(chain(literal('a'), literal('a')), literal('a')), either(chain(literal('a'), literal('a')), literal('a'))))
rx_test('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa b', 'aaaaa b', chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), either(chain(literal('a'), literal('a')), literal('a'))))))))))))))))))))))))))))))))))))))))))
rx_test('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa b', nil, chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), chain(either(chain(literal('a'), literal('a')), literal('a')), either(chain(literal('a'), literal('a')), literal('a'))))))))))))))))))))))))))))))))))))))))))
rx_test('A', '', chain(literal('A'), star(literal('A'))))
rx_test('AAA+, would do again.', 'AA+, would do again.', chain(literal('A'), star(literal('A'))))
rx_test('abdomen', 'omen', chain(literal('a'), chain(chain(either(literal('b'), literal('c')), star(either(literal('b'), literal('c')))), literal('d'))))
rx_test('abcbdcb', 'cb', chain(literal('a'), chain(chain(either(literal('b'), literal('c')), star(either(literal('b'), literal('c')))), literal('d'))))
rx_test('addomen', nil, chain(literal('a'), chain(chain(either(literal('b'), literal('c')), star(either(literal('b'), literal('c')))), literal('d'))))
rx_test('dogcatcatdogcatdogdogcatdogcatcatdogcatdogdogcatlikely', 'ly', chain(chain(either(chain(literal('c'), chain(literal('a'), literal('t'))), chain(literal('d'), chain(literal('o'), literal('g')))), star(either(chain(literal('c'), chain(literal('a'), literal('t'))), chain(literal('d'), chain(literal('o'), literal('g')))))), chain(literal('l'), chain(literal('i'), chain(literal('k'), literal('e'))))))
rx_test('', '', star(literal('a')))
rx_test('', nil, chain(literal('b'), star(literal('a'))))
rx_test('bc', 'c', chain(literal('b'), star(literal('a'))))
rx_test('abcd', 'd', chain(literal('a'), chain(star(literal('b')), literal('c'))))
rx_test('abd', nil, chain(literal('a'), chain(star(literal('b')), literal('c'))))
rx_test('yoaabcaccaabbaba', 'ba', chain(literal('y'), chain(literal('o'), chain(star(either(chain(literal('a'), literal('b')), chain(star(literal('c')), literal('a')))), chain(literal('b'), literal('a'))))))
rx_test('ad attacks', ' attacks', chain(literal('a'), chain(star(star(literal('b'))), literal('d'))))
rx_test('abdomen', 'omen', chain(literal('a'), chain(star(star(literal('b'))), literal('d'))))

return rx_test
