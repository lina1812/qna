(window["webpackJsonp"] = window["webpackJsonp"] || []).push([[3],{

/***/ "./app/javascript/vote.js":
/*!********************************!*\
  !*** ./app/javascript/vote.js ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function($) {$(document).on('turbolinks:load', function () {
  $('.vote-links a').on('ajax:success', function (e) {
    var votableType = e.detail[3];
    var votableId = e.detail[4];
    var voteId = e.detail[0];
    var oldScore = $('score-' + votableType + '-' + votableId).text();
    oldScore = parseInt(oldScore);
    $('.vote-' + votableType + '-' + votableId + ' .score').html(oldScore + e.detail[2]);
    $('.vote-' + votableType + '-' + votableId + ' .destroy-link').removeClass('hidden');
    var href = $('.vote-' + votableType + '-' + votableId + ' .destroy-link').attr("href");
    href = href.replace("ID", voteId);
    $('.vote-' + votableType + '-' + votableId + ' .destroy-link').attr("href", href);
    $('.vote-' + votableType + '-' + votableId + ' .vote-links').addClass('hidden');
  }).on('ajax:error', function (e) {
    var errors = e.detail[0];
    var voteErrors = $(this).parent().find('.vote-errors');
    $.each(errors, function (index, value) {
      voteErrors.append('<p>' + value + '</p>');
    });
  });
});
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! jquery/src/jquery */ "./node_modules/jquery/src/jquery.js")))

/***/ })

}]);
//# sourceMappingURL=3-651b4aa807676bd6cdd5.chunk.js.map