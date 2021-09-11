import consumer from "./consumer"

$(document).on('turbolinks:load', function(){
  if ($('.question').length) {
    consumer.subscriptions.create({ channel: "QuestionChannel", id: $('.question').data('id') }, {
      received(data) {
        this.appendLine(data)
      },
    
      appendLine(data) {
        const html = this.createLine(data)
        $('.other-answers').append(html)
      },
    
      createLine(data) {
        return data.html
      }
    })
  }
})
