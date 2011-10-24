// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

//= require underscore
//= require backbone
//= require backbone.authtokenadapter
//= require fullcalendar
//= require gcal

// TWITTER BOOTSTRAP
//= require bootstrap-twipsy
//= require bootstrap-popover
//= require bootstrap-modal
//= require bootstrap-dropdown

//= require app

//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers
//= require_tree ../templates
//= require_tree .

//var top = $(window).scrollTop();
//var left = $(window).scrollLeft();
//$('body').css('overflow', 'hidden');
//$(window).scroll(function(){
//  $(this).scrollTop(top).scrollLeft(left);
//});

(function( $ ) {
  $.fn.notify = function( options ) {
    
    var settings = {
      'type'     :  'info',
      'message' :  'Oops' 
    };
    
    var $this = $(this);
    
    return this.each(function() {
      if(options) {
        $.extend( settings, options );
      }
      
      $this.addClass(settings.type);
      var type = settings.type.charAt(0).toUpperCase() + settings.type.substr(1);
      $this.html('<a class="close" id="notify_close" href="#">×</a><strong>' + type + ': </strong>' + settings.message);
      
      $this.animate({"right" : "+=992px"} , 500, "swing"); // slide out
      $('#notify_close').click(function() {
        $this.animate({"right" : "-=992px"} , 500, "swing"); // slide out
      });
    });
    
  };
})( jQuery );