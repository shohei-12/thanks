$(function () {
  $(".posts").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".post",
    button: ".vmb1",
    scrollThreshold: false,
    status: ".pls1",
  });

  $(".my-posts").infiniteScroll({
    path: ".tc1 .pagination a[rel='next']",
    append: ".my-post",
    button: ".vmb1",
    scrollThreshold: false,
    status: ".pls1",
  });

  $(".like-posts").infiniteScroll({
    path: ".tc2 .pagination a[rel='next']",
    append: ".like-post",
    button: ".vmb2",
    scrollThreshold: false,
    status: ".pls2",
  });

  if (!$(".pagination").length) {
    $(".view-more-button").hide();
  }
});
