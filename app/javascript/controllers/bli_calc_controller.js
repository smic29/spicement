import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bli-calc"
export default class extends Controller {
  static targets = ["total", "currency", "cost", "quantity"]

  initialize() {
    const exchangeRateEl = document.querySelector('#billing_ex_rate')
    this.exchangeRate = parseFloat(exchangeRateEl.value) || 0

    exchangeRateEl.addEventListener('input', () => {
      this.exchangeRate = parseFloat(exchangeRateEl.value) || 0
      this.updateTotal()
    })
  }

  updateTotal() {
    const cost = parseFloat(this.costTarget.value) || 0
    const quantity = parseFloat(this.quantityTarget.value) || 0

    let result = cost * quantity

    if (this.currencyTarget.value !== 'PHP') {
      result = result * this.exchangeRate
    }

    this.totalTarget.value = result.toFixed(2)
  }
}
