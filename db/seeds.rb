# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create :name => "Admin", :email => "admin@longhall.com", :password => "123456", :role => 0
user = User.create :name => "User", :email => "user@longhall.com", :password => "123456"
leader = User.create :name => "Leader", :email => "leader@longhall.com", :password => "123456", :role => 2
project = Project.create :title => "Just another project", :description => "Nothing interesting here, don't waste your time by opening this.", :user_id => user.id
scope = Scope.create :title => "iOS Production", :project_id => project.id, :description => "Again just another dummy app.", :version => 1.5, :user_id => user.id
issue = Issue.create :title => "Login form has a IDOR!! hooray!!", :scope_id => scope.id, :status => 0, :severity => 2, :description => "Nothing serious, ignore this issue.", :solution => "Waiting for a solution for a fictional issue.", :user_id => user.id
comment = Comment.create :message => "First test comment", :issue_id => issue.id, :user_id => user.id