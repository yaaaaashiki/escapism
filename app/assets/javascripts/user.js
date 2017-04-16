$(document).ready(function() {
  $("p").click(function(){
    $("p").css("color", "red")
    $("div .before-image-left").fadeOut("slow")
    $("div .before-image-right").fadeOut("slow")
    $("div .after-image-left").fadeIn("slow")
    $("div .after-image-right").fadeIn("slow")

  });
});
