document.addEventListener('page:change', function() {
  document.getElementById('transition-wrap').className += 'animated fadeIn';
});
document.addEventListener('page:fetch', function() {
  document.getElementById('transition-wrap').className += 'animated fadeOut';
});
