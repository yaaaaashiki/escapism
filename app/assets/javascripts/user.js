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
 
  setInterval(function(){
    $("div .before-image-left").fadeToggle(3000)
    $("div .after-image-left").fadeToggle(3000)
    $("div .before-image-right").fadeToggle(3000)
    $("div .after-image-right").fadeToggle(3000)
  }, 3000);

  
  
//  $("p").on('click', function(){
//  });
});
