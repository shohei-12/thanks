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

  $(".followings").infiniteScroll({
    path: ".tc2 .pagination a[rel='next']",
    append: ".following",
    history: false,
    button: ".vmb2",
    scrollThreshold: false,
    status: ".pls2",
  });

  $(".followers").infiniteScroll({
    path: ".tc3 .pagination a[rel='next']",
    append: ".follower",
    history: false,
    button: ".vmb3",
    scrollThreshold: false,
    status: ".pls3",
  });

  $(".like-posts").infiniteScroll({
    path: ".tc4 .pagination a[rel='next']",
    append: ".like-post",
    history: false,
    button: ".vmb4",
    scrollThreshold: false,
    status: ".pls4",
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

  if (!$(".tc1 .pagination").length) {
    $(".tc1 .vmb1").hide();
  }

  if (!$(".tc2 .pagination").length) {
    $(".tc2 .vmb2").hide();
  }

  if (!$(".tc3 .pagination").length) {
    $(".tc3 .vmb3").hide();
  }

  if (!$(".tc4 .pagination").length) {
    $(".tc4 .vmb4").hide();
  }
});
