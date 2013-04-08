class StaticPagesController < ApplicationController
	layout "society_layout", :only => :society_home

	def home
	end

	def help
	end

	def about
	end

	def contact
	end

	def society_home
	end

end
