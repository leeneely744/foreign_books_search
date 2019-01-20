$(function() {
  $("#panel-btn").click(function() {
    $("#panel").slideToggle(200);
    $("#panel-btn-icon").toggleClass("open");
    $("#book_search").toggleClass("open");
    return false;
  });
});