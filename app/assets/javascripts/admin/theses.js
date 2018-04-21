$(function() {
  $('#directory').change(event => {
    let placeholder = $('<option>', {text: '選択してください'});
    let selectMenu = $('[id$=_relative_path]').empty()
                                           .append(placeholder);
    for (let file of event.target.files) {
      let relativePath = file.webkitRelativePath;
      let option = $('<option>', {value: relativePath, text: relativePath});
      selectMenu.append(option);
    }
  });
});