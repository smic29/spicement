import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  connect() {
    const toastEl = this.element
    const toast = new bootstrap.Toast(toastEl)

    toast.show()

    this.element.addEventListener('hidden.bs.toast', () => {
      this.element.remove()
    })
  }
}
