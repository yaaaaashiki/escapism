$(window).on('load', function(){
  $('body').addClass('fade-in');
});

window.onunload = function(){};

$(window).bind("unload",function(){});

$(function() {
  $('a').on('click', function(e) {
    $('body').addClass('fade-out');

    url = $(this).attr('href');
    setTimeout(function(){
      window.location = url;
    }, 800);

    return false;
  });
});
