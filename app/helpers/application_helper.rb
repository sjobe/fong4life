module ApplicationHelper
  def formatted_date(date, include_time = true)
    if include_time
      date.strftime("%A, %d %b %Y, %l:%M %p") 
    else
       date.strftime("%A, %d %b %Y") 
    end
  end

  def active_section(top_page)
    if controller_name == top_page
      'nav-item-active'
    end
  end
end
