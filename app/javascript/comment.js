$(document).on("turbolinks:load", function () {
  if (!$(".post-details .comments .comment").length) {
    $(".post-details .comment-list, .post-details .comment-sort").hide();
  }
});
