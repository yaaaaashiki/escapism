$("#l_1").change(function(){
  $.ajax({
    url: "search/ajax",
    type: "GET",
    data: {
      labo_id: 1,
    },
    success: function(data) {
  }});
});
