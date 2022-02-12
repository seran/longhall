module ProjectHelper

	def status_color(status)
		case status
		when 'open'
			return "#078080"
		when 'completed'
			return '#f45d48'
		when 'cancelled'
			return '#f45d48'
		else
			return '#000000'
		end
	end
end
