crumb :root do
  link 'Home', root_path
end

crumb :donors do
 link 'Donors', donors_path
end

crumb :blood_drives do
  link 'Blood Drives', blood_drives_path
end

crumb :emergencies do
  link 'Emergencies', blood_drives_path
end

crumb :facebook_posts do
  link 'Facebook Page', facebook_posts_path
end

crumb :new_facebook_post do
  link 'New Post', new_facebook_post_path
  parent :facebook_posts
end

crumb :show_facebook_post do |id|
  link 'Show Facebook Post', facebook_post_path(id: id)
  parent :facebook_posts
end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).