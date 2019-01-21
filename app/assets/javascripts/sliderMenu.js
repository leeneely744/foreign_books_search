$(function() {
  $("#panel-btn").click(function() {
    $("#panel").slideToggle(200);
    $("#panel-btn-icon").toggleClass("open");
    $(".search-forms-panel").toggleClass("open");
    return false;
  });
});