import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "links" ]
  connect() {
    const turbo_frame = document.querySelector('#admin_frame') || document.querySelector('#users_frame')

    this.setInitialActive(turbo_frame)
    this.setEventListener()
  }

  setInitialActive(frame) {
    this.linksTargets.forEach((link) => {
      if (link.href === frame.src || link.textContent === 'Home' ) {
        link.classList.add('active', 'pe-none')
      } else {
        link.classList.remove('active')
      }
    })
  }

  setEventListener() {
    document.addEventListener('turbo:before-frame-render', (e) => {
      this.linksTargets.forEach((link) => {
        if (link.href === e.target.src) {
          link.classList.add('active', 'pe-none')
        } else {
          link.classList.remove('active', 'pe-none')
        }
      })
    })
  }
}
