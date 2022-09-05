
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
//= require clients
//= require fields
//= require users
//= require sales
//= require field_sale
//= require batch_payments
//= require land_fees
//= require land_fee_payments
//= require lands

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

// Redondeo un numero a 2 decimales
function roundToTwo(num) {
    return +(Math.round(num + "e+2")  + "e-2")
}

function addClassValid( input ) {
  input.classList.remove('is-invalid')
  input.classList.add('is-valid')
}

function addClassInvalid( input ) {
  input.classList.remove('is-valid')
  input.classList.add('is-invalid')
}

function setInputDate(_id){
    var _dat = document.querySelector(_id);
    var hoy = new Date(),
        d = hoy.getDate(),
        m = hoy.getMonth()+1, 
        y = hoy.getFullYear(),
        data;

    if(d < 10){
        d = "0"+d;
    };
    if(m < 10){
        m = "0"+m;
    };

    data = y+"-"+m+"-"+d;
    _dat.value = data;
}

function format_date(date) {
  let d = date.split('-')
  return `${d[2]}-${d[1]}-${d[0]}`
}

// formato de numero para monedas
const numberFormat = new Intl.NumberFormat('es-AR')

$(document).on('ready', function () {
  // initialization of custom select
  // $('.js-select').selectpicker();

  // initialization of hamburger
  $.HSCore.helpers.HSHamburgers.init('.hamburger');

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

  // initialization of HSDropdown component
  $.HSCore.components.HSDropdown.init($('[data-dropdown-target]'), {dropdownHideOnScroll: false})

  // initialization of custom scrollbar
  $.HSCore.components.HSScrollBar.init($('.js-custom-scroll'))
})