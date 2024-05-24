import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quote-total-calc"
export default class extends Controller {
  static targets = ["total", "currency", "factor"]

  initialize() {
    const exchangeRateEl = document.querySelector('#quotation_exchange_rate')
    this.exchangeRate = parseFloat(exchangeRateEl.value) || 0

    exchangeRateEl.addEventListener('input', () => {
      this.exchangeRate = parseFloat(exchangeRateEl.value) || 0
      this.updateTotal()
    })
  }

  updateTotal(){
    let result = 0
    this.factorTargets.forEach((factor) => {
      if (result === 0) {
        result = result + parseFloat(factor.value) || 0
      } else {
        result = result * parseFloat(factor.value) || 0
      }
    })

    if (this.currencyTarget.value !== 'PHP') {
      result = result * this.exchangeRate
    }
    this.totalTarget.value = result.toFixed(2)
  }
}
