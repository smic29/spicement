import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showpassword"
export default class extends Controller {
  connect() {
    const iconEl = this.element.firstElementChild
    const inputEl = this.element.nextElementSibling

    this.element.addEventListener('click',() => {
      if (iconEl.classList.contains('bi-eye-slash')) {
        iconEl.classList.remove('bi-eye-slash')
        iconEl.classList.add('bi-eye')
        inputEl.type = 'text'
      } else {
        iconEl.classList.remove('bi-eye')
        iconEl.classList.add('bi-eye-slash')
        inputEl.type = 'password'
      }
    })
  }
}
