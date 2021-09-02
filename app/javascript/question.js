$(document).on('turbolinks:load', function(){
   $('.question').on('click', '.edit-question-link', function(e) {
       e.preventDefault();
       $(this).hide();
       var questionId = $(this).data('questionId');
       console.log(questionId);
       $('form#edit-question-' + questionId).removeClass('hidden');
   })
   
   $('.question').on('click', '.purge-file-link', function(e) {
       e.preventDefault();
       var questionId = $(this).data('questionId');
       var fileId = $(this).data('fileId');
       $.ajax({
          type: 'GET',
          url: '/questions/'+questionId+'/purge_file?file_id='+fileId,
       })
   })
});
