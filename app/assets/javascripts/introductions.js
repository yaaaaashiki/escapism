/* スクロールでフェードイン */
/* 参考サイト: https://theorthodoxworks.com/web-design/scrollanimation/ */
$('.fade-in').css('visibility','hidden');
$(window).scroll(function() {
  var windowHeight = $(window).height();
  var topWindow    = $(window).scrollTop();
  $('.fade-in').each(function() {
    var targetPosition = $(this).offset().top;
    if (topWindow > targetPosition - windowHeight + 100){
     $(this).addClass("fade-in-down");
    }
  });
});

$(function() {

  $(".icons img").mouseover(function(){
    if($(this).hasClass("default_img")){
      $(this).hide();
      $(this).next().show();
    }
  }).mouseout(function(){
     if($(this).hasClass("mouseover_img")){
      $(this).hide();
      $(this).prev().show();
    }
  });

});


/*フォントサイズや色の変更*/
$(".comment_title").css('font-size', '20px');
$(".comment_list").find("p").css("font-size", "14px");

/*男女比をjQueryで描画*/
var dataset = [{"laboProfessor":"tobe", "man":19, "woman":0},
                {"laboProfessor":"sumi", "man":15, "woman":2},
                {"laboProfessor":"sakuta", "man":13, "woman":1},
                {"laboProfessor":"komiyama", "man":12, "woman":3},
                {"laboProfessor":"harada", "man":15, "woman":5},
                {"laboProfessor":"lopez", "man":16, "woman":5},
                {"laboProfessor":"ohara", "man":17, "woman":0},
                {"laboProfessor":"durst", "man":7, "woman":2}
                ];
for(var i=0;i<dataset.length;i++){
    var d = dataset[i];
    var $gender_ratio_text = $("#gender_ratio_text_" + d.laboProfessor);
    var $gender_ratio_rect = $("#gender_ratio_rect_" + d.laboProfessor);
    var $svg = $(document.createElementNS("http://www.w3.org/2000/svg", "svg"));
    var $rect_m = $(document.createElementNS("http://www.w3.org/2000/svg", "rect"));
    var $rect_w = $(document.createElementNS("http://www.w3.org/2000/svg", "rect"));
    var $width = $gender_ratio_rect.width();
    $gender_ratio_text.text("男女比 " + d.man + ":" + d.woman);
    $svg.attr({
        width: $width*(2/3),
        height: 28
    });
    $rect_m.attr({
        width: $width*(d.man/(d.man+d.woman))*(2/3),
        height: 28,
        x: 0,
        y: 0,
        fill: "#A9D0F5"
    });
    $rect_w.attr({
        width: $width*(d.woman/(d.man+d.woman))*(2/3),
        height: 28,
        x: $width*(d.man/(d.man+d.woman))*(2/3),
        y: 0,
        fill: "#F5A9F2"
    });
    $svg.append($rect_m);
    $svg.append($rect_w);
    $gender_ratio_rect.append($svg);
}


