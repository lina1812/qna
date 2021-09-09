(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[1],{

/***/ "./app/javascript/file.js":
/*!********************************!*\
  !*** ./app/javascript/file.js ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function($) {$(document).on('turbolinks:load', function () {
  $('.files').on('click', '.purge-file-link', function (e) {
    e.preventDefault();
    var fileId = $(this).data('fileId');
    $.ajax({
      type: 'DELETE',
      url: '/files/' + fileId,
      success: function success(data, textStatus, jqXHR) {
        $(e.target).parent().hide();
      }
    });
  });
});
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! jquery/src/jquery */ "./node_modules/jquery/src/jquery.js")))

/***/ })

}]);
//# sourceMappingURL=1-56182ecdd17fe4255e40.chunk.js.map