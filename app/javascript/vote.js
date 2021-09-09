$(document).on('turbolinks:load', function(){
  $('.vote-links a').on('ajax:success', function(e) {
    var votableType = e.detail[0].votable_type.toLowerCase();
    var votableId = e.detail[0].votable_id;
    var voteId = e.detail[0].id;
    var oldScore = $('.vote-' + votableType + '-' + votableId + ' .score').text();
    oldScore = parseInt(oldScore);
    $('.vote-' + votableType + '-' + votableId + ' .score').html(oldScore + e.detail[0].value);
    $('.vote-' + votableType + '-'+ votableId + ' .destroy-link').show();
    var href = $('.vote-' + votableType + '-'+ votableId + ' .destroy-link').attr("href");
    href = href.replace("ID", voteId );
    $('.vote-' + votableType + '-'+ votableId + ' .destroy-link').attr("href", href);
    $('.vote-' + votableType + '-'+ votableId + ' .vote-links').addClass('hidden');
   })
       .on('ajax:error', function (e) {
           var errors = e.detail[0];
           var voteErrors = $(this).parent().find('.vote-errors')
           $.each(errors, function(index, value) {
             voteErrors.append('<p>' + value + '</p>');
           })

       })
});
