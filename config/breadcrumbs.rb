# crumb :projects do
#   link "Projects", projects_path
# end

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

crumb :admin_dashboard do
  link '<i class="fa fa-dashboard"></i> Home'.html_safe, admin_dashboard_path
end

crumb :edit_admin_site do
  link '設定', edit_admin_site_path
  parent :admin_dashboard
end

crumb :admin_users do
  link 'ユーザー', admin_users_path
  parent :admin_dashboard
end

crumb :admin_user do |user|
  link 'プロフィール', admin_user_path(user)
  parent :admin_users
end

crumb :new_admin_user do
  link 'ユーザーの作成', new_admin_user_path
  parent :admin_users
end

crumb :admin_invitations do
  link '招待', admin_invitations_path
  parent :admin_dashboard
end

crumb :new_admin_invitation do
  link '招待状の作成', new_admin_invitation_path
  parent :admin_invitations
end

crumb :admin_categories do
  link 'カテゴリー', admin_categories_path
  parent :admin_dashboard
end

crumb :edit_admin_category do |category|
  link 'カテゴリー編集', edit_admin_category_path(category)
  parent :admin_categories
end

crumb :admin_tags do 
  link 'タグ', admin_tags_path
  parent :admin_dashboard
end

crumb :edit_admin_tag do |tag|
  link 'タグ編集', edit_admin_tag_path(tag)
  parent :admin_tags
end

crumb :admin_authors do
  link '著者', admin_authors_path
  parent :admin_dashboard
end

crumb :edit_admin_author do |author|
  link '著者編集', edit_admin_author_path(author)
  parent :admin_authors
end

crumb :admin_articles do
  link '記事', admin_articles_path
  parent :admin_dashboard
end

crumb :new_admin_article do
  link '記事作成', new_admin_article_path
  parent :admin_articles
end

crumb :edit_admin_article do |article|
  link '記事編集', edit_admin_article_path(article.uuid)
  parent :admin_articles
end
