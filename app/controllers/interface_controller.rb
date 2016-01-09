class InterfaceController < ApplicationController
	def task_params
		params.require(:task).permit(:name, :important, :urgent, :done, :owner)
	end
	def create
		@hascontent = params.has_key?(:name)
		@task = Task.new(task_params, :done => 'false')
		if @task.save
			redirect_to '/app/'
		end
	end
	def destroy
		@task = Task.find_by id: params[:id]
		@task.destroy
		redirect_to '/app/'
	end
	def done
		@task = Task.find(params[:id])
		@task.done = '1'
		@task.save
		redirect_to '/app/'
	end
	def index

		redirect_to '/auth/login' if !user_signed_in?

		# initialise empty task for the form #

		@task = Task.new

		##########################
		# Construct task queries #
		##########################

		@owner = current_user.id if user_signed_in?

		# Important & Urgent #
		
		@important_urgent_query = {
			owner: @owner,
			important: '1',
			urgent: '1',
			done: '0'
		}

		# Important & NOT urgent #

		@important_not_urgent_query = {
			owner: @owner,
			important: '1',
			urgent: '0',
			done: '0'
		}

		# NOT important & urgent #

		@not_important_urgent_query = {
			owner: @owner,
			important: '0',
			urgent: '1',
			done: '0'
		}

		# NOT important & NOT urgent #

		@not_important_not_urgent_query = {
			owner: @owner,
			important: '0',
			urgent: '0',
			done: '0'
		}

		@tasks_archive_query = {
			owner: @owner,
			done: '1'
		}
		@tasks_archive = Task.where( @tasks_archive_query )
		@important_urgent = Task.where(@important_urgent_query)
		@important_not_urgent = Task.where(@important_not_urgent_query)
		@not_important_urgent = Task.where(@not_important_urgent_query)
		@not_important_not_urgent = Task.where(@not_important_not_urgent_query)
	end
end