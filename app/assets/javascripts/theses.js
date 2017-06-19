$(function() {

  console.log(location.search.match(/&l=(.*?)(&|&|$)/)[1]);

  $("[id^=l]").change(function() {
    $("[id^=l]").removeClass('checked');
    $(this).addClass('checked');
  });


});
