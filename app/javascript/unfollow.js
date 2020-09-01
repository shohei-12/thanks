$(function () {
  $(document).on(
    {
      mouseenter: function () {
        $(this).attr("value", "フォロー解除");
      },
      mouseleave: function () {
        $(this).attr("value", "フォロー中");
      },
    },
    ".unfollow-btn"
  );
});
