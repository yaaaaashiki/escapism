$(window).on('load', function(){
  $('body').removeClass('fadeout');
});

$(function() {
  $('a:not([href^="#"]):not([target])').on('click', function(e){
    e.preventDefault();
    url = $(this).attr('href');
    if (url !== '') {
      $('body').addClass('fadeout');
      setTimeout(function(){
        window.location = url;
      }, 800);
    }
    return false;
  });
});
