// $(document).on("turbolinks:load", function () {
//   var isLoading = false;

//   function loadMoreData() {
//     var nextPage = $(".pagination .next a").attr("href");
//     if (
//       nextPage &&
//       !isLoading &&
//       $(window).scrollTop() > $(document).height() - $(window).height() - 100
//     ) {
//       isLoading = true;
//       $.getScript(nextPage)
//         .done(function () {
//           isLoading = false;
//         })
//         .fail(function () {
//           isLoading = false;
//         });
//     }
//   }

//   $(window).on("scroll", loadMoreData);
// });
