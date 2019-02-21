/* global $ */
/* global jQuery */

(function($){
    $(".sort_link.asc").append(" の低い順");
    $(".sort_link.desc").append(" の高い順");
    $(".sort_link").not('.asc, .desc').css({"color": "gray"});
}(jQuery));