module ApplicationHelper
  
  #RTeturn the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Fill in the blanks w/ automated grading"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
end
