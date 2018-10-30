require('pg')

class Property

	attr_accessor :value, :number_of_bedrooms, :square_footage, :build

	attr_reader :id

	def initialize(specs)
		@value = specs['value'].to_i
		@number_of_bedrooms = specs['number_of_bedrooms'].to_i
		@square_footage = specs['square_footage'].to_f
		@build = specs['build']
		@id = specs['id'] if specs['id']
	end

	def save
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "INSERT INTO property_records (value, number_of_bedrooms, square_footage, build) VALUES ($1, $2, $3, $4) RETURNING *;"
		values = [@value, @number_of_bedrooms, @square_footage, @build]
		db.prepare('save', sql)
		@id = db.exec_prepared('save', values)[0]['id']
		db.close()
	end

	def update
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "UPDATE property_records SET (value, number_of_bedrooms, square_footage, build) = ($1, $2, $3, $4) WHERE id = $5; "
		values = [@value, @number_of_bedrooms, @square_footage, @build, @id]
		db.prepare('update', sql)
		db.exec_prepared('update', values)
		db.close()
	end

	def Property.delete_all()
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "DELETE from property_records;"
		db.prepare('delete_all', sql)
		db.exec_prepared('delete_all')
		db.close()
	end

	def delete()
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "DELETE from property_records WHERE id = $1"
		values = [@id]
		db.prepare('delete', sql)
		db.exec_prepared('delete', values)
		db.close()
	end

	def Property.find(id_search)
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "SELECT * FROM property_records WHERE id = $1"
		values = [id_search]
		db.prepare('find', sql)
		result = db.exec_prepared('find', values)
		db.close()
		return Property.new(result[0])
	end

	def Property.find_build(build_search)
		db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
		sql = "SELECT * FROM property_records WHERE build = $1"
		values = [build_search]
		db.prepare('find_build', sql)
		results = db.exec_prepared('find_build', values)
		return_array = results.map {|result| Property.new(result)}
		db.close()
		return return_array.count==0 ? nil : return_array
	end
end
