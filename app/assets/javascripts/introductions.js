/* スクロールでフェードイン */
/* 参考サイト: https://theorthodoxworks.com/web-design/scrollanimation/ */
$('.fade-in').css('visibility','hidden');
$(window).scroll(function() {
  var windowHeight = $(window).height();
  var topWindow    = $(window).scrollTop();
  $('.fade-in').each(function() {
    var targetPosition = $(this).offset().top;
    if (topWindow > targetPosition - windowHeight + 100){
     $(this).addClass("fade-in-down");
    }
  });
});

$(function() {

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
