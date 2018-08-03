$(function() {
  $('[id^=l]').change(function() {
    $('#search-form').submit();
  });
});
