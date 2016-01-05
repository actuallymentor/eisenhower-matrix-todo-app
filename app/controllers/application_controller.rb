class ApplicationController < ActionController::Base
	def task_params
		params.require(:task).permit(:name, :important, :urgent, :done, :owner)
	end
	def create
		@task = Task.new(task_params, :done => 'false', :owner => 'Mentor')
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

		# initialise empty task for the form #

		@task = Task.new

		##########################
		# Construct task queries #
		##########################

		# Important & Urgent #
		
		@important_urgent_query = {
			# owner: 'Mentor',
			important: '1',
			urgent: '1',
			done: '0'
		}

		# Important & NOT urgent #

		@important_not_urgent_query = {
			# owner: 'Mentor',
			important: '1',
			urgent: '0',
			done: '0'
		}

		# NOT important & urgent #

		@not_important_urgent_query = {
			# owner: 'Mentor',
			important: '0',
			urgent: '1',
			done: '0'
		}

		# NOT important & NOT urgent #

		@not_important_not_urgent_query = {
			# owner: 'Mentor',
			important: '0',
			urgent: '0',
			done: '0'
		}

		@tasks_archive = Task.all.limit(10)
		@important_urgent = Task.where(@important_urgent_query)
		@important_not_urgent = Task.where(@important_not_urgent_query)
		@not_important_urgent = Task.where(@not_important_urgent_query)
		@not_important_not_urgent = Task.where(@not_important_not_urgent_query)
	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
