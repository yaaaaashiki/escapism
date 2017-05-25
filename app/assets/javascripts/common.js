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
    $('body').addClass('fade-out');

    url = $(this).attr('href');
    setTimeout(function(){
      window.location = url;
    }, 800);

    return false;
  });

});
