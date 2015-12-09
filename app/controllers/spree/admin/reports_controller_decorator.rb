module Spree
  module Admin
    ReportsController.class_eval do

      def sales_tax
        if params[:completed_at_gt].blank?
          params[:completed_at_gt] = Time.zone.now.beginning_of_month
        else
          params[:completed_at_gt] = Time.zone.parse(params[:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
        end

        if params && !params[:completed_at_lt].blank?
          params[:completed_at_lt] = Time.zone.parse(params[:completed_at_lt]).end_of_day
        end

        params[:s] ||= "completed_at desc"


        zone_members = Spree::TaxRate.all.joins(:zone).joins(zone: :zone_members).map{|x| x.zone.members }.flatten
        states = zone_members.map{ |x| x.zoneable if x.zoneable_type == "Spree::State" }.uniq
        countries = zone_members.map{ |x| x.zoneable if x.zoneable_type == "Spree::Country" }.uniq.delete_if &:nil?
        orders = []
        orders += Spree::Order.where("completed_at > ? && completed_at < ?", params[:completed_at_gt], params[:completed_at_lt])
            .joins(:ship_address)
            .where(spree_addresses: { state_id: states.map(&:id) } ) unless states.empty?
        orders += Spree::Order.where("completed_at > ? && completed_at < ?", params[:completed_at_gt], params[:completed_at_lt])
                .joins(:ship_address)
                .where(spree_addresses: { country_id: countries.map(&:id)  } ) unless countries.empty?

        @totals = {}
        orders.each do |order|
          @totals[order.ship_address.state.name] = 0.0 if @totals[order.ship_address.state.name].nil?
          if order.additional_tax_total == 0.0
            rate = Spree::Order.first.tax_zone.tax_rates.first.amount.to_f
            total = order.item_total.to_f
            tax = (total - (total / (1 + rate) )).to_f
            @totals[order.ship_address.state.name] +=  tax
          else
            @totals[order.ship_address.state.name] +=  order.additional_tax_total
          end
        end
      end


    end
  end
end
