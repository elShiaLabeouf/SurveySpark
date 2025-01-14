import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["successSubmissionMessage", "surveyRow"]

  stubUser(event) {
    document.cookie = `user_id=${event.target.value}; path=/`;
  }

  refreshPage(event) {
    const parser = new URL(window.location);
    parser.searchParams.set(event.target.name, event.target.value);
    window.location = parser.href;
  }

  goToPage(event) {
    window.location = `${event.target.value}${location.search}`
  }

  successSubmissionMessageTargetConnected(messageDiv) {
    setTimeout(() => {
      messageDiv.classList.add("d-none");
    }, 3500);
  }

  surveyRowTargetConnected(surveyRow) {
    setTimeout(() => {
      surveyRow.classList.remove("fresh-survey-row");
    }, 500);
  }
}
