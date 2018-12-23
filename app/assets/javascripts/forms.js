/* global $ */
/* global jQuery */

(function($){
    $(document).on('turbolinks:load', function() {
       $(".grouped-multi-select-box").select2({
           theme: "bootstrap"
       });
    });
}(jQuery));