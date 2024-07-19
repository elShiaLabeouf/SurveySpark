import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["successSubmissionMessage", "surveyRow"]

  stubUser(event) {
    document.cookie = `user_id=${event.target.value}; path=/`;
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
