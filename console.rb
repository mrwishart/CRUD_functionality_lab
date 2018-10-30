require_relative('./property')
require('pp')

Property.delete_all()

prop1 = Property.new({'value' => 150000, 'number_of_bedrooms' => 2, 'square_footage' => 600.3, 'build' => 'semi'})

prop2 = Property.new({'value' => 600000, 'number_of_bedrooms' => 4, 'square_footage' => 1206.7, 'build' => 'detached'})

prop3 = Property.new({'value' => 5000000, 'number_of_bedrooms' => 7, 'square_footage' => 4586.7, 'build' => 'apricot'})

prop4 = Property.new({'value' => 7000000, 'number_of_bedrooms' => 7, 'square_footage' => 4586.7, 'build' => 'banana'})

prop1.save()
prop2.save()
prop3.save()
prop4.save()

prop1.build = 'banana'
prop1.update()
prop_find = Property.find(prop2.id)
prop_find_build = Property.find_build('banana')

puts prop_find.value

p prop_find_build
