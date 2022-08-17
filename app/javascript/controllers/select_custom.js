$(document).ready(function () {
  let all = $('.select2');

  all.each(function () {
    $(this).select2()
  })

  $('#work_day_project_id').on('select2:select', function (e) {
    var elem = $('#work_day_user_id')
    let id = $(this).find(':selected').val() > 0 ? $(this).find(':selected').val() : 'empty'
    elem.select2({
      ajax: {
        url: 'http://localhost:3000/users_by_project_id/' + id,
        dataType: 'json',
        data: function (term) {
          return {
            term: term
          }
        },
        processResults: function (data) {
          return {
            results: $.map(data.results, function (item) {
              return {
                id: item.id,
                text: item.name
              }
            })
          }
        }
      }
    });
  });

  $('#work_day_user_id').on('select2:select', function (e) {
    var elem = $('#work_day_project_id')
    let id = $(this).find(':selected').val() > 0 ? $(this).find(':selected').val() : 'empty'
    elem.select2({
      ajax: {
        url: 'http://localhost:3000/projects_by_user_id/' + id,
        dataType: 'json',
        data: function (term) {
          return {
            term: term
          }
        },
        processResults: function (data) {
          return {
            results: $.map(data.results, function (item) {
              return {
                id: item.id,
                text: item.name
              }
            })
          }
        }
      }
    });
  });

});