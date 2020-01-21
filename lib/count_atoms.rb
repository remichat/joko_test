def count_atoms(formula)
  atoms = {}
  chars = formula.is_a?(String) ? formula.split('') : formula
  i = 0
  while i < chars.length
    if chars[i].match?(/[A-Z]/)
      atom = find_atom(chars[i..-1])
      counted_atom = parse_atom(atom)
      atoms = add_to_count(atoms, counted_atom)
      i += atom.length
    elsif chars[i].match?(/[\(\[\{]/)
      group_info = find_group_info(chars[i..-1])
      new_count = count_atoms(group_info[:formula])
      atoms = add_to_count(atoms, new_count, group_info[:multiplier])
      i += group_info[:next_index] + 1
    end
  end
  atoms
end

def find_atom(chars)
  next_stop = chars[1..-1].index { |char| char.match?(/[A-Z\(\[\{]/) } || chars.length - 1
  chars[0..next_stop]
end

def parse_atom(chars)
  groups = chars.join('').scan(/([A-Z][a-z]?)(\d*)/)
  atom = groups[0][0]
  occurences = groups[0][1] == '' ? 1 : groups[0][1].to_i
  result = {}
  result[atom] = occurences
  result
end

def find_group_info(chars)
  count_nests = 0
  i = 0
  chars.each_with_index do |char, index|
    count_nests += 1 if char.match?(/[\(\[\{]/)
    count_nests -= 1 if char.match?(/[\)\]\}]/)
    if count_nests.zero?
      i = index
      break
    end
  end
  has_multiplier = chars[i + 1].nil? ? false : chars[i + 1].match?(/\d/)
  next_index = has_multiplier ? i + 1 : i
  multiplier = has_multiplier ? chars[i + 1].to_i : 1
  { formula: chars[1...i], next_index: next_index, multiplier: multiplier}
end

def add_to_count(main_count, partial_count, multiplier = 1)
  partial_count.each do |atom, occurences|
    main_count[atom] = main_count.fetch(atom, 0) + occurences * multiplier
  end
  main_count
end

# p count_atoms("H2O[Mg4(KO)2]3")
