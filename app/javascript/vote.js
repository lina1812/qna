$(document).on('turbolinks:load', function(){
   $(document).on('click', ".delete-vote", function(e) {
       e.preventDefault();
       var voteId = $(this).data('voteId');
       $.ajax({
          type: 'DELETE',
          url: '/votes/'+voteId
       })
   })
});
