// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(function () {
  // hamburger menu
  $(".hamburger").on("click", function () {
    if ($(this).hasClass("open")) {
      $(this).removeClass("open");
      $("nav").removeClass("open");
    } else {
      $(this).addClass("open");
      $("nav").addClass("open");
    }
  });

  $(".posts").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".post",
    history: false,
    prefill: false,
  });

  $(".my-posts").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".post",
    history: false,
    prefill: true,
  });

  $(".like-posts").infiniteScroll({
    path: ".pagination a[rel='next']",
    append: ".like-post",
    history: false,
    prefill: true,
  });
});
