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


/*男女比をjQueryで描画*/
var dataset = [{"laboProfessor":"tobe", "man":4, "woman":6},
                {"laboProfessor":"sumi", "man":14, "woman":1},
                {"laboProfessor":"sakuta", "man":5, "woman":3},
                {"laboProfessor":"komiyama", "man":9, "woman":2},
                {"laboProfessor":"harada", "man":10, "woman":4},
                {"laboProfessor":"lopez", "man":11, "woman":2},
                {"laboProfessor":"ohara", "man":4, "woman":5},
                {"laboProfessor":"durst", "man":13, "woman":0}
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
        fill: "#0000ff"
    });
    $rect_w.attr({
        width: $width*(d.woman/(d.man+d.woman))*(2/3),
        height: 28,
        x: $width*(d.man/(d.man+d.woman))*(2/3),
        y: 0,
        fill: "#ff1493"
    });
    $svg.append($rect_m);
    $svg.append($rect_w);
    $gender_ratio_rect.append($svg);
}
