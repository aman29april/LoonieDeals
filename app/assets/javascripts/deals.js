
$(document).on("click", "#upvote-button, #downvote-button", function (e) {
  e.preventDefault();

  var button = $(this);
  var dealId = button.data("deal-id");
  var url =
    button.attr("id") === "upvote-button"
      ? "/deals/" + dealId + "/upvote"
      : "/deals/" + dealId + "/downvote";

  $.ajax({
    type: "POST",
    url: url,
    dataType: "script",
  });
});
