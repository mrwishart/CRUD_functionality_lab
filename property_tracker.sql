DROP TABLE IF EXISTS property_records;
CREATE TABLE property_records(
	id SERIAL4,
	value INT,
	number_of_bedrooms INT,
	square_footage FLOAT,
	build VARCHAR(255)
);
