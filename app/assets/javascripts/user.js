$(document).ready(function() {
//  $("p").click(function(){
//    $("p").css("color", "red")
//    $("div .before-image-left").fadeOut("slow")
//    $("div .before-image-right").fadeOut("slow")
//    $("div .after-image-left").fadeIn("slow")
//    $("div .after-image-right").fadeIn("slow")
//  });
//  $("p").click(function(){
//    $("p").toggle(
//      function() {
//    		 $("div .before-image-left").fadeOut("slow")
//    	},
//    	function() {
//    		 $("div .after-image-left").fadeIn("slow")
//    	}
//    );
//  });
//
  $("p").on('click', function(){
    $("div .before-image-left").fadeOut(5000)
    $("div .before-image-left").fadeIn(5000)
});



});
