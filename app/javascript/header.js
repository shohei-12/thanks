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
});
