#只要資料庫有關聯，就可以直接fake
namespace :dev do

  task :fake => :environment do
    puts "Fake data..."
    User.delete_all
    Article.delete_all
    Comment.delete_all

    #user創建如果用devise 就要有password和email
     users = []
     20.times do |n|
      users << User.create( :password => "12345678", :username => Faker::Internet.user_name, :birthday => Faker::Date.backward(14), :email => Faker::Internet.email )
    end

    100.times do |i|
      puts "Generate article #{i}"
      t = Article.create( :title => Faker::Lorem.word, :description => Faker::Lorem.paragraph, :user => users.sample )

      10.times do |j|
        puts "  Generate comment #{j}"
        t.comments.create( :content => Faker::Lorem.paragraph, :user => users.sample )
      end
    end
  end
end
