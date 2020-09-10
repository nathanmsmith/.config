def test
  x = [1, 2, 3]
  x.each do
    y = 'blah'
    test
  end
end
