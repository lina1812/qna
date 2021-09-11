import consumer from "./consumer"


consumer.subscriptions.create({ channel: "QuestionsChannel" }, {
  received(data) {
    this.appendLine(data)
  },

  appendLine(data) {
    if ($('.question-list').length) {
    const html = this.createLine(data)
    $('.question-list').append(html)
    }
  },

  createLine(data) {
    return `  
      <tr>
        <td>${data["title"]}</td>
        <td><a href="/questions/${data["id"]}">Show</a></td>
    </tr>
    `
  }
})

