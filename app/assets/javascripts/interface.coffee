$ ->
	#############################
	# Catch the clicking of 'done'
	#############################
	$("body.app_index").on 'click', '#active_tasks .task a.active', (e) ->
		e.preventDefault()
		thisobj = $(this)
		done_task = 'empty'
		$.post( "/app/done/", { id: $(this).parent().attr('id') } )
		$.ajax
				url: "/api/"
				dataType: "json"
				data: { latest: 'true' }
				error: (jqXHR, textStatus, errorThrown) ->
					console.log(textStatus)
				success: (data, textStatus, jqXHR) ->
					done_task = thisobj.parent().clone().children().remove().end().text()
					task_done(data.id, done_task)
		thisobj.parent().remove()

	# Catch the clicking of 'delete'
	$("body").on 'click', '#done_tasks .task a.done', (e) ->
		e.preventDefault()
		thisobj = $(this)
		$.post( "/app/delete/", { id: $(this).parent().attr('id') } )
		thisobj.parent().remove()
		

	# Task to archive
	task_done = (id, task) ->
			$('#done_tasks ul').prepend('<li class="task done" id="' + id + '">' + task + '<a class="done btn btn-secondary pull-right btn-sm" href="/app/done/' + id + '">delete</a>' + "</li>")
		
	#############################
	# New task submit
	#############################

	$('body.app_index').on 'submit', 'form', (e) ->
		# stop regular form
		e.preventDefault()
		# do ajax call
		thisobj = $(this)
		formvalues = thisobj.serializeArray()
		# check what boxes are checked
		important = $('.important_checkbox').prop("checked")
		urgent = $('.urgent_checkbox').prop("checked")
		task = formvalues[2].value
		thisobj.ajaxSubmit success: (e) ->
			$.ajax
				url: "/api/"
				dataType: "json"
				data: { latest: 'true' }
				error: (jqXHR, textStatus, errorThrown) ->
					console.log(textStatus)
				success: (data, textStatus, jqXHR) ->
					if important and urgent
						imp_urg(data.id)
					if important and not urgent
						imp_nurg(data.id)
					if not important and urgent
						nimp_urg(data.id)
					if not important and not urgent
						nimp_nurg(data.id)
					return

			#clear form
			thisobj.closest('form').find("input[type=text]").val("")
			thisobj.closest('form').find("input[type=checkbox]").attr('checked', false)
			$('#task_modal').modal('hide')
		# show new item
		imp_urg = (e) ->
			$('.important.urgent ul').append('<li class="task" id="' + e + '">' + task + '<a class="active btn btn-secondary pull-right btn-sm" href="/app/done/' + e + '">done</a>' + "</li>")
		imp_nurg = (e) ->
			$('.important.noturgent ul').append('<li class="task" id="' + e + '">' + task + '<a class="active btn btn-secondary pull-right btn-sm" href="/app/done/' + e + '">done</a>' + "</li>")
		nimp_urg = (e) ->
			$('.notimportant.urgent ul').append('<li class="task" id="' + e + '">' + task + '<a class="active btn btn-secondary pull-right btn-sm" href="/app/done/' + e + '">done</a>' + "</li>")
		nimp_nurg = (e) ->
			$('.notimportant.noturgent ul').append('<li class="task" id="' + e + '">' + task + '<a class="active btn btn-secondary pull-right btn-sm" href="/app/done/' + e + '">done</a>' + "</li>")

	#############################
	# Keyboard shortcuts
	#############################

	$('body.app_index').on 'keypress', (e) ->
		console.log(e.which)
		if e.which is 116
			$('#task_modal').modal('show')
























