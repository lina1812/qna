(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[2],{

/***/ "./app/javascript/question.js":
/*!************************************!*\
  !*** ./app/javascript/question.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function($) {$(document).on('turbolinks:load', function () {
  $('.question').on('click', '.edit-question-link', function (e) {
    e.preventDefault();
    $(this).hide();
    var questionId = $(this).data('questionId');
    console.log(questionId);
    $('form#edit-question-' + questionId).removeClass('hidden');
  });
});
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! jquery/src/jquery */ "./node_modules/jquery/src/jquery.js")))

/***/ })

}]);
//# sourceMappingURL=2-8630d30fb8f75450b073.chunk.js.map