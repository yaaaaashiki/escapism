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
    $('.thesis_form').hide();
    $('[class*=theses_others]').hide();
  });

  $('#number_of_registration').change(function() {
    let number = $(this).val();
    let forms = $('.thesis_form');
    
    if (number === '') {
      forms.hide();
    } else {
      forms.show();
      $(`.thesis_form:gt(${number - 1})`).hide();
    }
  });
  $(`.thesis_form`).hide();

  $('[id$=_others_number_of_registration]').change(function() {
    // 更新対象を探すために$(this)[0]のidからindexを取り出す
    // idの形式：theses_[index]_others_number_of_registration
    let targetIndex = $(this)[0].id.slice(7, 8);
    let forms = $(`.theses_others_${targetIndex}`);
    let number = $(this).val();
    if (number === '') {
      forms.hide();
    } else {
      forms.show();
      $(`.theses_others_${targetIndex}:gt(${number - 1})`).hide();
    }
  });
  $('[class*=theses_others]').hide();
});