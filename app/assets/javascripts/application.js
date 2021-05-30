//= require rails-ujs
//= require activestorage
//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap.min
//= require unify/hs.megamenu
//= require unify/jquery.mCustomScrollbar.concat.min
//= require unify/hs.core
//= require unify/hs.hamburgers
//= require unify/hs.header
//= require unify/hs.scrollbar
//= require unify/hs.go-to



// require_tree .



$(document).on('ready', function () {
  // initialization of go to
  $.HSCore.components.HSGoTo.init('.js-go-to');

  // initialization of tabs
  // $.HSCore.components.HSTabs.init('[role="tablist"]');

  // initialization of chart pies
  // var items = $.HSCore.components.HSChartPie.init('.js-pie');

  // initialization of HSScrollBar component
  $.HSCore.components.HSScrollBar.init( $('.js-scrollbar') );
});

$(window).on('load', function () {
  // initialization of header
  $.HSCore.components.HSHeader.init($('#js-header'));
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  // initialization of HSMegaMenu component
  $('.js-mega-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: $('.container'),
    breakpoint: 991
  });

  // initialization of horizontal progress bars
//   setTimeout(function () { // important in this case
//     var horizontalProgressBars = $.HSCore.components.HSProgressBar.init('.js-hr-progress-bar', {
//       direction: 'horizontal',
//       indicatorSelector: '.js-hr-progress-bar-indicator'
//     });
//   }, 1);
});

// $(window).on('resize', function () {
//   setTimeout(function () {
//     $.HSCore.components.HSTabs.init('[role="tablist"]');
//   }, 200);
// });