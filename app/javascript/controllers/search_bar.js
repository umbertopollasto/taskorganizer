class SearchBar {
  constructor(hostname, url) {
    this.hostname = (hostname) ? hostname : 'http://localhost:3000'
    this.url = (url) ? url : '/search_users/'
    this.id = '#search_bar'
    this.user_id = ''
  }

  search = (id) => {
    this.user_id = (id) ? id : 'null'
    console.log(this.hostname)
    $(this.id).select2({
      ajax: {
        url: this.hostname + this.url + this.user_id,
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
  }
}



function init() {
  let bar = new SearchBar()
  bar.search()

  $(bar.id).on('select2:select', function (e) {
    let id = $(this).find(':selected').val()
    bar.search(id)
  });
}


$(document).ready(function () {
  init()
})