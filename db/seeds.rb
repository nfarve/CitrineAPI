# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SI_list = 
	[["minute", "min",60, "s"],["hour", "h", 3600, "s"], ["day", "d", 86400, "s"], ["degree", "°", Math::PI/180, "rad" ], 
	["'", "'", Math::PI/10800, "rad"], ["second", '"', Math::PI/648000, "rad"] ,["hectare", "ha", 10000, "m\u{00B2}"], 
	["litre", "L",0.001,"m\u{00B3}"],["tonne", "t", 1000, "kg"]
]

SI_list.each do |name, symbol, factor, unit|
	Conversion.create(name: name, symbol: symbol, factor: factor, unit: unit)
end
