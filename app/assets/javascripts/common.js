$(window).on('load', function(){
  $('section').removeClass('fadeout');
});

$(function() {
  $('a:not([href^="#"]):not([target])').on('click', function(e){
    e.preventDefault();
    url = $(this).attr('href');
    console.log(url);
    if (url !== '') {
      $('section').addClass('fadeout');
      setTimeout(function(){
        window.location = url;
      }, 800);
    }
    return false;
  });
});
