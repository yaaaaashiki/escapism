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
    if(!$(this).hasClass('carousel-control')) {
      $('body').addClass('fade-out');
      url = $(this).attr('href');
      setTimeout(function(){
        window.location = url;
      }, 800);
    }
    else{
      if($(this).hasClass('right')){
        $('#carousel-example-generic').carousel('next');
      }
      else{
        $('#carousel-example-generic').carousel('prev');
      }
    }
    return false;
  });

  $('.navigate-anchor ul li').mouseover(function() {
    $(this).addClass("bottom-border");
  }).mouseout(function() {
    $(this).removeClass("bottom-border");
  });

   $('.l-footerNav ul li').mouseover(function() {
    $(this).addClass("bottom-border");
  }).mouseout(function() {
    $(this).removeClass("bottom-border");
  });

  $(".icons img").mouseover(function(){
    if($(this).hasClass("default_img")){
      $(this).hide();
      $(this).next().show();
    }
  }).mouseout(function(){
     if($(this).hasClass("mouseover_img")){
      $(this).hide();
      $(this).prev().show();
    }
  });
});
