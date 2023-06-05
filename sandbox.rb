def balanced_parens(n)
  return [""] if n == 0

  result = []

  balanced_parens(n-1).each do |item|
    result << "()#{item}"
    result << "(#{item})"
    result << "#{item}()"
  end

  result.uniq
end

p balanced_parens(4).sort
