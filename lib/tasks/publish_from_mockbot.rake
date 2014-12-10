namespace :mockbot do
  desc %(Publish a product from MockBot with the given sku.)
  task :publish, [:sku] => :environment do |t, args|

    args.with_defaults sku: nil
    sku = args.sku
    Spree::Product.publish_from_mockbot(sku)

  end

  desc 'Publish products that are ready_to_publish'
  task publish_all: :environment do
    page = 1
    ideas = Spree::Mockbot::Idea.all(params: {page: page})
    until ideas.empty?
      ideas.each do |idea|
        if idea.status == 'ready_to_publish'
          puts idea.sku
          puts Time.now
          begin
            Spree::Product.publish_from_mockbot(idea.sku)
          rescue Exception => e
            puts e
          end
        end
      end
      page += 1
      ideas = Spree::Mockbot::Idea.all(params: {page: page})
    end
  end

end
