import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  stubUser(event) {
    document.cookie = `user_id=${event.target.value}; path=/`;
  }
}
