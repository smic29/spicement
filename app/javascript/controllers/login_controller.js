import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="login"
export default class extends Controller {
  connect() {
    const input_email = this.element.querySelector('input#user_email')

    if (input_email.value !== '') {
      const invalidMsg = this.element.querySelector('div.text-danger')
      console.log(invalidMsg)
      invalidMsg.classList.remove('d-none')
    }
  }
}
