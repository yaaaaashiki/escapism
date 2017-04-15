$(document).ready(function() {
  $("p").click(function(){
    $("p").css("color", "red")
    $("div .col-jquery-left").css("background-image", "url(assets/kana2.jpg)")
    $("div .col-jquery-right").css("background-image", "url(assets/kana2.jpg)")
    $("div .col-jquery-left").css("background-size", "cover")
    $("div .col-jquery-left").css("background-size", "contain")
    $("div .col-jquery-right").css("background-size", "cover")
    $("div .col-jquery-right").css("background-size", "contain")
    $("div .image-left").fadeOut("slow")
    $("div .image-right").fadeOut("slow")
  });
});
