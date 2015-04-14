namespace :dev do

  task :fake => :environment do
    puts "Fake data..."

    100.times do |i|
      puts "Generate article #{i}"
      t = Article.create( :title => Faker::Lorem.word, :description => Faker::Lorem.paragraph )

      10.times do |j|
        puts "  Generate comment #{j}"
        t.comments.create( :content => Faker::Lorem.paragraph  )
      end
    end

  end

end