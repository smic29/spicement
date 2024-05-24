import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quote-line-items"
export default class extends Controller {
  static targets = ["container", "template"]

  initialize() {
    this.indexValue = 1
  }

  add(e) {
    e.preventDefault()
    
    const newIndex = this.indexValue++
    const content = this.templateTarget.innerHTML
    .replace(/name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g, `name="quotation[quote_line_items_attributes][${newIndex}][`)
    .replace(/id="quotation_quote_line_items_attributes_\d+_/g, `id="quotation_quote_line_items_attributes_${newIndex}_`)
    .replace("d-none","")

    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(e) {
    e.preventDefault()
    const lineItemEl = e.target.closest('.row')
    const lineItemIndex = this.getIndexFromEl(lineItemEl)

    if (lineItemIndex !== null) {
      lineItemEl.remove()
      this.indexValue--
      this.updateIndices(lineItemIndex)
    }
  }

  getIndexFromEl(el) {
    const idPattern = /quote_line_items_attributes_(\d+)_/
    const match = el.querySelector('[id]')?.id.match(idPattern)
    return match ? parseInt(match[1], 10) : null
  }

  updateIndices(startIndex) {
    const lineItemElements = this.containerTarget.querySelectorAll('.row')

    lineItemElements.forEach((element, index) => {
      if (index >= startIndex) {
        const newIndex = index 
        const namePattern = /name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g
        const idPattern = /id="quotation_quote_line_items_attributes_\d+_/g

        element.innerHTML = element.innerHTML
        .replace(namePattern, `name="quotation[quote_line_items_attributes][${newIndex}][`)
        .replace(idPattern, `id="quotation_quote_line_items_attributes_${newIndex}_`)
      }
    })
  }
}
