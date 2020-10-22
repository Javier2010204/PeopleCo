module ApplicationHelper

	def circle_img url,size=50
		div = content_tag(:div, "", class: "circle cover", style:"height: #{size}px; width: #{size}px;background-image:url(#{url_for(url)})")
		div.html_safe
	end	
end
