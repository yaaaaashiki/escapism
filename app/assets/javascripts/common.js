window.onunload = function(){
  $('body').addClass('fade-in');
};

$(window).on("unload",function(){
});

$(window).on('load', function(){
  $('body').addClass('fade-in');
});

$(function() {
  $('a').on('click', function(e) {
    if(!$(this).hasclass('carousel-control')) {
      $('body').addClass('fade-out');
      url = $(this).attr('href');
      setTimeout(function(){
        window.location = url;
      }, 800);
    }
    return false;
  });

  $('.navigate-anchor ul li').mouseover(function() {
    $(this).addClass("bottom-border");
  }).mouseout(function() {
    $(this).removeClass("bottom-border");
  });

   $('.l-footerNav ul li').mouseover(function() {
    $(this).addClass("bottom-border-orange");
  }).mouseout(function() {
    $(this).removeClass("bottom-border-orange");
  });

});
