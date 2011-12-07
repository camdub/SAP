//= require jquery
//= require jquery_ujs

//= require_self

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
// require_tree ./views
//= require ./views/events_index
//= require ./views/event_detail
//= require_tree ./routers
//= require_tree ../templates
//= require_tree .

//var top = $(window).scrollTop();
//var left = $(window).scrollLeft();
//$('body').css('overflow', 'hidden');
//$(window).scroll(function(){
//  $(this).scrollTop(top).scrollLeft(left);
//});

var faye = new Faye.Client('http://localhost:9292/faye');
 

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
      
      $this.removeClass('info warning error success').addClass(settings.type);
      var type = settings.type.charAt(0).toUpperCase() + settings.type.substr(1);
      $this.html('<a class="close" id="notify_close" href="#">×</a><strong>' + type + ': </strong>' + settings.message);
      
      $this.animate({"right" : "+=992px"} , 500, "swing"); // slide out
      $('#notify_close').click(function() {
        $this.animate({"right" : "-=992px"} , 500, "swing"); // slide out
      });
      setTimeout(function(){$('#notify_close').trigger('click')},3000);
    });
    
  };
})( jQuery );