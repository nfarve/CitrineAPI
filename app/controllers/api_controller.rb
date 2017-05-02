class ApiController < ApplicationController

	def index
		if (params.has_key?(:units))
			# puts params[:units].split(/([*\/\(\)])/).reject{ |c| c.empty?}
			param_list = params[:units].split(/([\(*\/\)])/).reject{ |c| c.empty?}
			param_list.each_with_index{|element, index|
				#Check to see if there is implicit multiplication 
				next_element = param_list[index+1]
				if not next_element.nil?
					if not ["*", "(", "/", ")"].include? element and not ["*", ")", "/"].include? next_element
						param_list.insert(index+1, "*")
					end
				end
			}
			@name, @factor = get_unit_name(param_list)
			
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
				#keep the key symbols	
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
					# if not a valid name or symbol
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
