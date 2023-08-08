module ApplicationHelper
	def flash_class(level)
	    case level.to_sym
	        when :notice then "alert alert-info alert-dismissible"
	        when :success then "alert alert-success alert-dismissible"
	        when :error then "alert alert-danger alert-dismissible"
	        when :danger then "alert alert-danger"
	        when :alert then "alert alert-danger alert-dismissible"
	    end
	end
end