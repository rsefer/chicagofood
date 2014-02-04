jQuery(document).ready(function($) {
	
	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd'
	});
	
	$('[data-print="true"]').click(function() {
		window.print();
	});
	
});
