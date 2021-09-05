$(document).on('turbolinks:load', function(){
   $('.links').on('click', '.delete-link', function(e) {
       e.preventDefault();
       var linkId = $(this).data('linkId');
       $.ajax({
          type: 'DELETE',
          url: '/links/'+linkId,
         success: function(data, textStatus, jqXHR){
           $(e.target).parent().hide()
         }
       })
   })
});
