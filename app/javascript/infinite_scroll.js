$(document).on("turbolinks:load", function () {
  $(".posts").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".post",
    history: false,
    button: ".vmb1",
    scrollThreshold: false,
    status: ".pls1",
  });

  $(".my-posts").infiniteScroll({
    path: ".tc1 .pagination a[rel='next']",
    append: ".my-post",
    history: false,
    button: ".vmb1",
    scrollThreshold: false,
    status: ".pls1",
  });

  $(".like-posts").infiniteScroll({
    path: ".tc2 .pagination a[rel='next']",
    append: ".like-post",
    history: false,
    button: ".vmb2",
    scrollThreshold: false,
    status: ".pls2",
  });

  $(".comments").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".comment",
    history: false,
    button: ".vmb1",
    scrollThreshold: false,
    status: ".pls1",
  });

  if (!$(".pagination").length) {
    $(".view-more-button").hide();
  }
});
