$(function() {

  if(location.search.match(/&l=(.*?)(&|&|$)/)[1]){
    console.log("#l=" + location.search.match(/&l=(.*?)(&|&|$)/)[1]);
    $('#l_' + location.search.match(/&l=(.*?)(&|&|$)/)[1]).addClass('checked');
  }

  $("[id^=l]").change(function() {
    $("[id^=l]").removeClass('checked');
    $(this).addClass('checked');
  });

});
