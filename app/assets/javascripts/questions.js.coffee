# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(function() {
  $.ajaxSetup({
	headers: {
		'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	}
  });

$( "#sortable" ).sortable({
	axis: 'y',
	stop: function(event, ui) {
		var data = $(this).sortable('serialize');
		console.log(data);

		$.ajax({
			data: data,
			type: 'POST',
			url: '/questions/update/'
		});
	}
});
$( "#sortable" ).disableSelection();
});
