module ApplicationHelper
  def formatted_date(date, include_time = true)
    if include_time
      date.strftime("%A, %d %b %Y, %l:%M %p") 
    else
       date.strftime("%A, %d %b %Y") 
    end
  end
end
