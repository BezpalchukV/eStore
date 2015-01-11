namespace :products do
  desc 'Updating products rating'
  task :update_ratings => :environment do
    puts 'Updating products ratings...'
    Product.all.each do |p|
      p.update_rating
    end
    puts 'DONE'
  end
end