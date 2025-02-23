import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const url = `/stream`
    this.source = new EventSource(url)
    this.source.onmessage = this.handleMessage.bind(this)
  }

  disconnect() {
    this.source.close()
  }

  handleMessage(event) {
    const eventData = JSON.parse(event.data)
    const appendAfterElement = document.querySelector('tr.no-surveys-caption')
    appendAfterElement.insertAdjacentHTML('beforebegin', eventData.table_row)
    if (eventData.last_row) this.source.close()
  }
}
