import consumer from "./consumer"
$(document).on('turbolinks:load', function(){
  $( ".comments" ).each(function( index , elem ) {
    consumer.subscriptions.create({ channel: "CommentChannel", id: $( elem ).data('id') }, {
      received(data) {
        this.appendLine(data)
      },
    
      appendLine(data) {
        const html = this.createLine(data)
        $( elem ).append(html)
      },
    
      createLine(data) {
        return data.html
      }
    })
  })
})
