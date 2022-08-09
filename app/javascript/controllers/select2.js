$(document).ready(function () {



  let all = $('.select2');
  console.log(all)

  all.each(function () {
    $(this).select2()
  })
});