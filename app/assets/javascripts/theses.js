$(function() {
  $("[id^=l]").change(function() {
    $("form").submit();
  });
});
