$(function() {
 
  setInterval(function(){
    $("div .before-image-left").fadeToggle(3000)
    $("div .after-image-left").fadeToggle(3000)
    $("div .before-image-right").fadeToggle(3000)
    $("div .after-image-right").fadeToggle(3000)
  }, 3000);

});
