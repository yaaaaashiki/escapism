$(function() {
  function onChangeUserRole() {
    let duration = 500;
    if ($("#user_role_labo_student").is(':checked')) {
      $("#labo_selecter").show(duration);
    } else {
      $("#labo_selecter").hide(duration);
    }
  }
  // 研究室に所属しているユーザには研究室選択項目を表示
  $("input[name = 'user[role]']").change(onChangeUserRole);
  onChangeUserRole();
  
  // 以下はapp/views/users/kana.html.slimでのみ使用
  setInterval(function(){
    $("div .before-image-left").fadeToggle(3000)
    $("div .after-image-left").fadeToggle(3000)
    $("div .before-image-right").fadeToggle(3000)
    $("div .after-image-right").fadeToggle(3000)
  }, 3000);
});
