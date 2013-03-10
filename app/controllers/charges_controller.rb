class ChargesController < ApplicationController

	def new
	end

	def create
		#amount in cents
		@amount = 3000

		customer = Stripe::Customer.create(
			:email => 'example@stripe.com',
			:card => params[:stripeToken]
			)

		charge = Stripe::Charge.create(
			:customer    => customer.id,
			:amount      => @amount,
			:description => 'Rails Stripe customer',
			:currency    => 'usd'
			)
	end

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to charges_path
end