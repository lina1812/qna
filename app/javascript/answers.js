$(document).on('turbolinks:load', function(){
   $('.answers').on('click', '.edit-answer-link', function(e) {
       e.preventDefault();
       $(this).hide();
       var answerId = $(this).data('answerId');
       console.log(answerId);
       $('form#edit-answer-' + answerId).removeClass('hidden');
   })
   
   
   $('.answers').on('click', '.delete-answer-link', function(e) {
       e.preventDefault();
       var answerId = $(this).data('answerId');
       $.ajax({
          type: 'DELETE',
          url: '/answers/'+answerId,
       })
   })
   
   $('.answers').on('click', '.best-answer-link', function(e) {
       e.preventDefault();
       var answerId = $(this).data('answerId');
       $.ajax({
          type: 'POST',
          url: '/answers/'+answerId+'/mark_as_best',
       })
   })
});

