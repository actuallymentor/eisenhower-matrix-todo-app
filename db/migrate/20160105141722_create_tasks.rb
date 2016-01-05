class CreateTasks < ActiveRecord::Migration
	def change
		create_table :tasks do |t|
			t.string :name
			t.string :owner
			t.string :important
			t.string :urgent
			t.string :done
			t.timestamps null: false
		end
	end
end
