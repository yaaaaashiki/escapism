$("[id^=l]").click(function(){
  $.ajax({
    url: "search/ajax",
    type: "GET",
    data: {
      labo_id: $("[name=l]:checked").val(),
    },
    success: function(data) {
  }});
});

