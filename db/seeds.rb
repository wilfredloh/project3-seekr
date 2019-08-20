# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



job1 = Job.create(:comp_name => 'unipec', :title => 'operation executive', :location => '3 temasek boulevard', :salary => '3,500-4,000', :url => 'www.linkedin.com', :deadline => "2019-10-09", :status => 'submitted application', :ind => 'shipping', :user_id => '1')

job2 = Job.create(:comp_name => 'google', :title => 'junior dev', :location => 'Google campus harborfront', :salary => '3,000-3,500', :url => 'www.google.com', :deadline => "2019-12-25", :status => 'preparing for interview', :ind => 'tech', :user_id => '1')

job3 = Job.create(:comp_name => 'trafigura', :title => 'senior operation executive', :location => '2 marina boulevard', :salary => '3,000-3,500', :url => 'www.jobs.sg.gov', :deadline => "2019-11-20", :status => 'first interview', :ind => 'shipping', :user_id => '1')

job4 = Job.create(:comp_name => 'revitalize', :title => 'admin exe', :location => '23 hello rd', :salary => '2,000-2,500', :url => 'www.monster.com', :deadline => "2019-10-01", :status => 'second interview', :ind => 'health', :user_id => '1')

job5 = Job.create(:comp_name => 'Kgroup', :title => 'instructor', :location => '3 bugis st', :salary => '2,000-2,500', :url => 'www.indeed.com', :deadline => "2019-10-20", :status => 'first interview', :ind => 'health', :user_id => '1')

job5 = Job.create(:comp_name => 'old chang kee', :title => 'junior kitchen assistant', :location => '33 pasir ris', :salary => '3,000-3,500', :url => 'www.jobstreet.com', :deadline => "2019-11-02", :status => 'preparing for interview', :ind => 'food', :user_id => '1')

job5 = Job.create(:comp_name => 'shangrila', :title => 'manager', :location => '47 Ordain Rd', :salary => '3,000-3,500', :url => 'www.jobstreet.com', :deadline => "2019-10-30", :status => 'second interview', :ind => 'food', :user_id => '1')

job6 = Job.create(:comp_name => 'fitness first', :title => 'instructor', :location => '79 anson rd', :salary => '2,000-2,500', :url => 'www.monster.com', :deadline => "2019-09-30", :status => 'saved', :ind => 'health', :user_id => '1')

job7 = Job.create(:comp_name => 'ninja van', :title => 'junior dev', :location => '333 ninja rd', :salary => '3,000-3,500', :url => 'www.indeed.com', :deadline => "2019-10-01", :status => 'submitted application', :ind => 'tech', :user_id => '1')