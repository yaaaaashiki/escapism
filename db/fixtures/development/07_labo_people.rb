16.times do |i|
  i += 1
  LaboPeople.seed(:id) do |l|
    if (i % 2 == 1)
      l.id = i / 2 + 1
    else
      l.id = i / 2
    end
    l.year = 2017
    l.gender = i % 2
    l.number_of_people = [15, 2, 7, 2, 13, 1, 17, 0, 12, 3, 19, 0, 15, 5, 16, 5][i-1]
  end
end
