$(function() {
  $('#directory_').change(event => {
    let placeholder = $('<option>', {text: '選択してください'});
    let selectMenu = $('[id*=url]').empty()
                                   .append(placeholder);
    for (let file of event.target.files) {
      let relativePath = file.webkitRelativePath;
      let option = $('<option>', {value: relativePath, text: relativePath});
      selectMenu.append(option);
    }

    $('.thesis_form input').val('');
    $('.thesis_form select').val(0);
    $('#number_of_registration').val(0);
    $('[class*=theses_others]').hide();
    $('.thesis_form').hide();
  });

  $('#number_of_registration').change(function() {
    let number = $(this).val();
    let forms = $('.thesis_form');

    forms.hide();
    if (number !== '') {
      $(`.thesis_form:lt(${number})`).show();
    }

    forms.find('input').val('');
    forms.find('select').val(0);
    $('[class*=theses_others]').hide();
  });
  $(`.thesis_form`).hide();

  $('[id$=_others_number_of_registration]').change(function() {
    // 更新対象を探すために$(this)の０番目のidからindexを取り出す
    // idの形式：theses_[index]_others_number_of_registration
    let targetIndex = $(this).get(0).id.slice(7, 8);
    let forms = $(`.theses_others_${targetIndex}`);
    let number = $(this).val();

    forms.hide();
    if (number !== '') {
      $(`.theses_others_${targetIndex}:lt(${number})`).show();
    }

    forms.find('input').val('');
    forms.find('select').val(0);
  });
  $('[class*=theses_others]').hide();
});