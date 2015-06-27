module ApplicationHelper
  def formatted_date(date, include_time = true)
    if include_time
      date.in_time_zone("EST").strftime("%A, %d %b %Y, %l:%M %p")+ ' EST'
    else
       date.strftime("%A, %d %b %Y")
    end
  end

  def facebook_date(date_string)
      date = DateTime.parse(date_string)
      date.in_time_zone("EST").strftime("%d %b %Y, %l:%M %p")+ ' EST'

  end

  def active_section(top_page)
    if controller_name == top_page
      'nav-item-active'
    end
  end

  def insight_value(val)
    if val.class == Hash
      val.map{|k,v| "(#{k.capitalize}) #{v}"}.join(', ')
    elsif val.class == Array
      val.present? ? val.join(',') : 'N/A'
    else
      val
    end
  end
end
