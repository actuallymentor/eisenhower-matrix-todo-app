class ApiController < ApplicationController
	def create
	end
	def read

		###############################
		# Read the query from the GET #
		###############################

		@task_query = {
			owner: params[:owner],
			important: params[:important],
			urgent: params[:urgent],
			done: params[:done]
		}

		# Remove empty parts of the query #
		@task_query.delete_if {|name,value| value.blank? }

		# Request the queried items from the database #
		@tasks_result = Task.where(@task_query)

		if params[:latest] == 'true'
			 @tasks_result = @tasks_result.last
		end

		# Return JSON of the query response #
		render json: @tasks_result
		
	end
	def update
	end
	def destroy
	end
end