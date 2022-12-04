str = "INSERT INTO students(class, sex, score) VALUES "
(1..100000).each do |i|
  insert_class = %w(A B C).sample
  sex = %w(男 女).sample
  score = (0..100).to_a.sample
  str += "('#{insert_class}', '#{sex}', #{score}), "
end
str.chomp!(', ')
str += ';'

print str
