$(document).on('turbolinks:load', function(){
   $('.files').on('click', '.purge-file-link', function(e) {
       e.preventDefault();
       var fileId = $(this).data('fileId');
       $.ajax({
          type: 'DELETE',
          url: '/files/'+fileId,
         success: function(data, textStatus, jqXHR){
           $(e.target).parent().hide()
         }
       })
   })
});
