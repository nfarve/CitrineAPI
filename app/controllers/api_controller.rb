class ApiController < ApplicationController

	def index
		if (params.has_key?(:units))
			# puts params[:units].split(/([*\/\(\)])/).reject{ |c| c.empty?}
			@name, @factor = get_unit_name(params[:units].split(/([\(*\/\)])/).reject{ |c| c.empty?})
			# @factor = 3.144343434
			
		else
			@name = "N/A"
			@factor = 0

		end		
		msg = {:unit_name => @name, :multiplication_factor => @factor}
		render :json => msg
	end

	def get_unit_name(array)
		string_name = ""
		string_factor = ""
		array.each do |entry|
			if (["*", "(", ")", "/"].include? entry)
				string_name += entry
				# puts string_name
				string_factor += entry
				# puts string_factor
			else
				result = Conversion.where("name = ? OR symbol = ? ", entry, entry)
				if not result.empty?
					string_name += result.last.unit
					# puts string_name
					string_factor += result.last.factor.to_s
					# puts string_factor
				else
					string_name = "N/A"
					string_factor = "0"
					return string_name, eval(string_factor).round(14)
				end
			end
		end
		return string_name, eval(string_factor).round(14)

	end

	private
		def api_params
			params.require(:unit)
		end

end
