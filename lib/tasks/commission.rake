namespace :commission do

  desc 'Get a list of products that are sold out'
  task :assign_store_commissions_to, [:email, :store_code, :rate] => :environment do |_t, args|
    user = Spree::User.find_by(email: args[:email])
    store = Spree::Store.find_by(code: args[:store_code])
    role = Spree::Role.find_by(name: 'commission agent')
    rate = args[:rate].to_f
    fail("Couldn't find comission agent with e-mail #{email}") if user.nil?
    fail("Couldn't find store with code #{store_code}") if store.nil?

    user.spree_roles << role unless user.spree_roles.include? role
    store.products.each do |product|
      if product.commission_agents.empty?
        ca = Spree::CommissionAgent.create(
            user_id: user.id,
            rate: rate,
            calculator_type: 'percent',
            product_id: product.id
        )

        ca.save!
        ca.line_items.each do |li|
          li.assign_commissions if li.commissions.empty?
        end
      end
    end

  end

end