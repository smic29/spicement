import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quote-line-items"
export default class extends Controller {
  static targets = ["container", "template"]

  initialize() {
    this.indexValue = this.templateTargets.length

    this.templateTargets.forEach((template) => {
      if (template.querySelector('input').value !== "") {
        template.querySelector('.d-none').classList.remove('d-none')
      }
    })
  }

  add(e) {
    e.preventDefault()
    
    const newIndex = this.indexValue++
    const content = this.templateTarget.innerHTML
    .replace(/name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g, `name="quotation[quote_line_items_attributes][${newIndex}][`)
    .replace(/id="quotation_quote_line_items_attributes_\d+_/g, `id="quotation_quote_line_items_attributes_${newIndex}_`)
    .replace("d-none","")
    .replace(/(<input[^>]* value=")[^"]*"/g, '$1"') 

    const wrappedContent =`<div data-quote-line-items-target="template" class="qli-template">${content}</div>`

    this.containerTarget.insertAdjacentHTML('beforeend', wrappedContent)
  }

  remove(e) {
    e.preventDefault()
    const lineItemEl = e.target.closest('.qli-template')
    const lineItemIndex = this.getIndexFromEl(lineItemEl)
    const hiddenIdEl = lineItemEl.nextElementSibling

    if (lineItemIndex !== null) {
      lineItemEl.remove()
      
      if (hiddenIdEl && hiddenIdEl.tagName === 'INPUT'){
        hiddenIdEl.remove()
      }
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
    const lineItemElements = this.containerTarget.querySelectorAll('.qli-template')

    lineItemElements.forEach((element, index) => {
      if (index >= startIndex) {
        const newIndex = index 
        const namePattern = /name="quotation\[quote_line_items_attributes\]\[\d+\]\[/g
        const idPattern = /id="quotation_quote_line_items_attributes_\d+_/g

        element.innerHTML = element.innerHTML
        .replace(namePattern, `name="quotation[quote_line_items_attributes][${newIndex}][`)
        .replace(idPattern, `id="quotation_quote_line_items_attributes_${newIndex}_`)

        const nextElement = element.nextElementSibling
        if (nextElement && nextElement.tagName === 'INPUT') {
            nextElement.name = `quotation[quote_line_items_attributes][${newIndex}][id]`
            nextElement.id = `quotation_quote_line_items_attributes_${newIndex}_id`
        }
      }
    })
  }
}
