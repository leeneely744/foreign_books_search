/* global $ */
/* global jQuery */

(function($){
    $(document).on('turbolinks:load', function() {
        /* 
        to sort-links.
        if involve 'asc' class, add ' の低い順' to text
        if involve 'desc' class, add ' の高い順' to text
        */
        $(".sort_link.asc").append(" の低い順");
        $(".sort_link.desc").append(" の高い順");
        $(".sort_link").not('.asc, .desc').css({"color": "gray"});
    });
}(jQuery));