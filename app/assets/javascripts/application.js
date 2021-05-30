
//= require rails-ujs
//= require activestorage
//= require unify/jquery.min
//= require unify/jquery-migrate.min
//= require unify/popper.min
//= require unify/bootstrap.min
//= require unify/jquery.cookie 
//= require unify/appear
//= require unify/jquery.mCustomScrollbar.concat.min
//= require unify/chartist.min
//= require unify/chartist-plugin-tooltip
//= require unify/hs.core
//= require unify/hs.side-nav
//= require unify/hs.hamburgers
//= require unify/hs.dropdown
//= require unify/hs.scrollbar
//= require unify/hs.area-chart
//= require unify/hs.donut-chart
//= require unify/hs.bar-chart
//= require unify/hs.toastr
//= require unify/hs.popup
//= require unify/noty.min
//= require plugins/datatables.min
//= require plugins/select2.full.min

// JS de mis paginas
//= require sectors
//= require apples

// require_tree .

function noty_alert(type, message) {
  let icon = (type === 'success') ? 'hs-admin-check' : 'hs-admin-close'
  var newNoty = new Noty({
    "type": type,
    "layout": "topRight",
    "timeout": 7000,
    "animation": {
      "open": "animated fadeIn",
      "close": "animated fadeOut"
    },
    "closeWith": [
      "click"
    ],
    "text": `<div class="g-mr-20"><div class="noty_body__icon"><i class="${icon}"></i></div></div><div>${message}.</div>`,
    "theme": "unify--v1"
  }).show();
}



$(document).on('ready', function () {
  // initialization of custom select
  // $('.js-select').selectpicker();

  // initialization of hamburger
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

  // initialization of charts
  // $.HSCore.components.HSAreaChart.init('.js-area-chart');
  // $.HSCore.components.HSDonutChart.init('.js-donut-chart');
  // $.HSCore.components.HSBarChart.init('.js-bar-chart');

  // initialization of sidebar navigation component
  $.HSCore.components.HSSideNav.init('.js-side-nav', {
    afterOpen: function() {
      setTimeout(function() {
        $.HSCore.components.HSAreaChart.init('.js-area-chart');
        $.HSCore.components.HSDonutChart.init('.js-donut-chart');
        $.HSCore.components.HSBarChart.init('.js-bar-chart');
      }, 400);
    },
    afterClose: function() {
      setTimeout(function() {
        $.HSCore.components.HSAreaChart.init('.js-area-chart');
        $.HSCore.components.HSDonutChart.init('.js-donut-chart');
        $.HSCore.components.HSBarChart.init('.js-bar-chart');
      }, 400);
    }
  });



  // initialization of range datepicker
  // $.HSCore.components.HSRangeDatepicker.init('#rangeDatepicker, #rangeDatepicker2, #rangeDatepicker3');

  // initialization of datepicker
  // $.HSCore.components.HSDatepicker.init('#datepicker', {
  //   dayNamesMin: [
  //     'SU',
  //     'MO',
  //     'TU',
  //     'WE',
  //     'TH',
  //     'FR',
  //     'SA'
  //   ]
  // });

  // initialization of HSDropdown component
  $.HSCore.components.HSDropdown.init($('[data-dropdown-target]'), {dropdownHideOnScroll: false});

  // initialization of custom scrollbar
  $.HSCore.components.HSScrollBar.init($('.js-custom-scroll'));

  // initialization of popups
  // $.HSCore.components.HSPopup.init('.js-fancybox', {
  //   btnTpl: {
  //     smallBtn: '<button data-fancybox-close class="btn g-pos-abs g-top-25 g-right-30 g-line-height-1 g-bg-transparent g-font-size-16 g-color-gray-light-v3 g-brd-none p-0" title=""><i class="hs-admin-close"></i></button>'
  //   }
  // });
});