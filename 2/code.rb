# we define methods on the fly to handle two inputs, one output, in sequence
# the name symbols don't actually do anything but are there for reference
$instructions = {
  1 => method(define_method(:add) {|a, b, c, seq| seq[c] = seq[a] + seq[b] }),
  2 => method(define_method(:multiply) {|a, b, c, seq| seq[c] = seq[a] * seq[b] })
}.freeze

def do_opcode(code)
  # if the opcode doesn't exist do nothing
  $instructions[code] || method(define_method(:empty) {|_, _, _, _| nil })
end

def run_program(program)
  program.each_slice(4).to_a.map do |seq|
    do_opcode(seq[0]).call(seq[1], seq[2], seq[3], program)
  end
end

raw_input = File.read('input').split(',').map(&:to_i)

# part one
input = raw_input.clone
input[1] = 12
input[2] = 2
run_program(input)
puts "part 1 answer: #{input[0]}"

# part two
# this is some ugly brute-forcing but I don't care
(0..99).each do |noun|
  (0..99).each do |verb|
    input = raw_input.clone
    input[1, 2] = [noun, verb]
    run_program(input)
    if input[0] == 19690720
      puts "part 2 answer: #{(100 * noun) + verb}"
    end
  end
end
