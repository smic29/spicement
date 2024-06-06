import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="billing-line-item"
export default class extends Controller {
  static targets = ["container", "template", "item", "exchange", "subtotal", "total"]

  initialize(){
    // console.log(this.templateTarget.innerHTML)
    // console.log(this.containerTarget.querySelectorAll('tr'))
    // console.log(this.itemTargets.length)
    // console.log(this.exchangeTarget)

    this.indexValue = this.itemTargets.length

    this.exchangeTarget.addEventListener("change", () => {
      this.updateSumTotal()
    })

    this.containerTarget.addEventListener("change",() => {
      this.updateSumTotal()
    })
  }

  updateSumTotal() {
    let sum = 0

    this.itemTargets.forEach((item) => {
      const totalEl = item.querySelector('[id*="_total"]')

      sum += parseFloat(totalEl.value === NaN || totalEl.value === '' ? 0 : totalEl.value )
    })

    const formattedSum = sum.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2})
    this.subtotalTarget.textContent = formattedSum

  }

  add() {
    const content = this.templateTarget.innerHTML
    .replace(/name="billing\[billing_line_items_attributes\]\[\d+\]\[/g, `name="billing[billing_line_items_attributes][${this.indexValue}][`)
    .replace(/id="billing_billing_line_items_attributes_\d+_/g, `id="billing_billing_line_items_attributes_${this.indexValue}_`)
    
    this.containerTarget.insertAdjacentHTML('beforeend', content)
    this.indexValue++
  }

  remove(e) {
    e.preventDefault()
    const lineItemEl = e.target.closest('tr')
    const lineItemIndex = this.getIndexFromEl(lineItemEl)

    if (lineItemIndex !== null) {
      lineItemEl.remove()

      this.indexValue--
      this.updateIndices(lineItemIndex)
      this.updateSumTotal()
    }
    
  }

  getIndexFromEl(el) {
    const idPattern = /billing_line_items_attributes_(\d+)_/
    const match = el.querySelector('[id]')?.id.match(idPattern)
    return match ? parseInt(match[1], 10) : null
  }

  updateIndices(startIndex) {
    const lineItemElements = this.containerTarget.querySelectorAll('tr')

    lineItemElements.forEach((element, index) => {
      if (index >= startIndex) {
        const newIndex = index 
        const namePattern = /name="billing\[billing_line_items_attributes\]\[\d+\]\[/g
        const idPattern = /id="billing_billing_line_items_attributes_\d+_/g
        
        // Save the current values
        const current_values = []
        element.querySelectorAll('input').forEach((input) => {
          current_values.push(input.value)
        })
        const select_value = element.querySelector('select').value

        element.innerHTML = element.innerHTML
        .replace(namePattern, `name="billing[billing_line_items_attributes][${newIndex}][`)
        .replace(idPattern, `id="billing_billing_line_items_attributes_${newIndex}_`)

        // Apply them after change
        element.querySelectorAll('input').forEach((input, index) => {
          input.value = current_values[index]
        })
        const selectEl = element.querySelector('select')
        selectEl.value = select_value
        
        const nextElement = element.nextElementSibling
        if (nextElement && nextElement.tagName === 'INPUT') {
            nextElement.name = `billing[billing_line_items_attributes][${newIndex}][id]`
            nextElement.id = `billing_billing_line_items_attributes_${newIndex}_id`
        }
      }
    })
  }


}
