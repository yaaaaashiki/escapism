$(function() {
  $("[id^=l]", ".labo-radio").change(function() {
    submitForm();
  });

  $("form").submit(function() {
    submitForm();
    return false;
  });

  $(".pagination").click(function() {
console.log("aaaaaaaaaaaaaaaaaaa");
    var nextPage = $(this).href;
    getNextPage(nextPage);
    window.history.pushState(null, null, nextPage);
    return false;
  });

  submitForm = function() {
    var labo_id = 'labo_id=' + $("[name=l]:checked").val();
    var q = 'q=' + $('#q').val();

    var nextPage = '/search/ajax?' + q;
    if ($("[name=l]:checked").val() != undefined) {
      nextPage = nextPage + '&' + labo_id;
    }
    
    getNextPage(nextPage)
    window.history.pushState(null, null, nextPage);
  };

  getNextPage = function(nextPage) {
    $('#search-result').load(nextPage + ' #search_result');
  };

  window.addEventListener('popstate', function(event) {
    getNextPage(location.href)
  },false );
});