class PagesController < ApplicationController
	def index
		if user_signed_in?
			redirect_to('/app/')
		end
	end
end
