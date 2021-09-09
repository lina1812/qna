(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[0],{

/***/ "./app/javascript/answers.js":
/*!***********************************!*\
  !*** ./app/javascript/answers.js ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function($) {$(document).on('turbolinks:load', function () {
  $('.answers').on('click', '.edit-answer-link', function (e) {
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    console.log(answerId);
    $('form#edit-answer-' + answerId).removeClass('hidden');
  });
  $('.answers').on('click', '.delete-answer-link', function (e) {
    e.preventDefault();
    var answerId = $(this).data('answerId');
    $.ajax({
      type: 'DELETE',
      url: '/answers/' + answerId
    });
  });
  $('.answers').on('click', '.best-answer-link', function (e) {
    e.preventDefault();
    var answerId = $(this).data('answerId');
    $.ajax({
      type: 'POST',
      url: '/answers/' + answerId + '/mark_as_best'
    });
  });
});
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! jquery/src/jquery */ "./node_modules/jquery/src/jquery.js")))

/***/ })

}]);
//# sourceMappingURL=0-170dab7f6445006ed2ee.chunk.js.map