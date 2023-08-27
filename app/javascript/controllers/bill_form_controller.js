import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "items", "clientInput", "clientsAttributes", "clientForm", "newItemBtn", "newClientBtn",
    "newClientConfirmation", "submit", "clientName", "clientAddress", "clientPostCode", "finalStep",
    "clientCity", "clientSiretNumber", "clientTvaNumber", "clientEmail", "clientPhoneNumber",
    "formContainer", "instructions", "itemsColumn", "clientColumnTitle", "itemsValidation",
    "step", "stepNumber", "stepValidation", "stepText", "itemsNumberAdded", "finalButton", "finalText"
  ]
  currentIndex = -1

  addItem(event) {
    event.preventDefault()
    this.currentIndex++
    this.itemsTargets[this.currentIndex].classList.remove("hidden")
    this.itemsTargets[this.currentIndex - 1].classList.add("hidden")
    if (this.currentIndex > 0) {
      this.itemsNumberAddedTarget.classList.remove("hidden")
      this.itemsValidationTarget.classList.remove("hidden")
      if (this.currentIndex === 1) {
        this.itemsNumberAddedTarget.innerHTML = `<i>(${this.currentIndex} item ajouté)</i>`
      } else {
        this.itemsNumberAddedTarget.innerHTML = `<i>(${this.currentIndex} items ajoutés)</i>`
      }
    }
  }

  clientConfirmation(event) {
    event.preventDefault()
    const clientSelected = document.getElementById("bill_client_attributes_name")
    this.clientsAttributesTargets.forEach((element) => {
      if (element.value === clientSelected.value) {
        const address = element.dataset.address
        const postCode = element.dataset.postCode
        const city = element.dataset.city
        const siretNumber = element.dataset.siretNumber
        const tvaNumber = element.dataset.tvaNumber
        const email = element.dataset.email
        const phoneNumber = element.dataset.phoneNumber
        this.clientNameTarget.setAttribute("value", clientSelected.value)
        this.clientAddressTarget.setAttribute("value", address)
        this.clientPostCodeTarget.setAttribute("value", postCode)
        this.clientCityTarget.setAttribute("value", city)
        this.clientSiretNumberTarget.setAttribute("value", siretNumber)
        this.clientTvaNumberTarget.setAttribute("value", tvaNumber)
        this.clientEmailTarget.setAttribute("value", email)
        this.clientPhoneNumberTarget.setAttribute("value", phoneNumber)
      }
    })
    this.clientColumnTitleTarget.classList.add("hidden")
    this.newItemBtnTarget.classList.remove("hidden")
    this.itemsColumnTarget.classList.remove("hidden")
    this.newClientBtnTarget.classList.add("hidden")
    this.clientInputTarget.classList.add("hidden")
    this.formContainerTarget.classList.remove("sm:max-w-sm")
    this.instructionsTargets.forEach((instruction) => {
      instruction.classList.add("hidden")
    })
    this.stepTargets[0].classList.remove("border-2")
    this.stepTargets[0].classList.add("bg-indigo-600")
    this.stepTargets[1].classList.remove("border-gray-300")
    this.stepTargets[1].classList.add("border-indigo-600")
    this.stepNumberTargets[0].classList.add("hidden")
    this.stepNumberTargets[1].classList.remove("text-gray-500")
    this.stepNumberTargets[1].classList.add("text-indigo-600")
    this.stepValidationTargets[0].classList.remove("hidden")
    this.stepTextTargets[0].classList.remove("text-indigo-600")
    this.stepTextTargets[0].classList.add("text-gray-900")
    this.stepTextTargets[0].innerText = "Client ajouté"
    this.stepTextTargets[1].classList.remove("text-gray-500")
    this.stepTextTargets[1].classList.add("text-indigo-600")
  }

  addClient(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.clientInputTarget.classList.add("hidden")
    this.clientFormTarget.classList.remove("hidden")
    this.newClientConfirmationTarget.classList.remove("hidden")
    this.instructionsTargets.forEach((instruction) => {
      instruction.classList.add("hidden")
    })
  }

  newClientConfirmation(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.clientFormTarget.classList.add("hidden")
    this.clientColumnTitleTarget.classList.add("hidden")
    this.newItemBtnTarget.classList.remove("hidden")
    this.formContainerTarget.classList.remove("sm:max-w-sm")
    this.itemsColumnTarget.classList.remove("hidden")
    this.stepTargets[0].classList.remove("border-2")
    this.stepTargets[0].classList.add("bg-indigo-600")
    this.stepTargets[1].classList.remove("border-gray-300")
    this.stepTargets[1].classList.add("border-indigo-600")
    this.stepNumberTargets[0].classList.add("hidden")
    this.stepNumberTargets[1].classList.remove("text-gray-500")
    this.stepNumberTargets[1].classList.add("text-indigo-600")
    this.stepValidationTargets[0].classList.remove("hidden")
    this.stepTextTargets[0].classList.remove("text-indigo-600")
    this.stepTextTargets[0].classList.add("text-gray-900")
    this.stepTextTargets[0].innerText = "Client ajouté"
    this.stepTextTargets[1].classList.remove("text-gray-500")
    this.stepTextTargets[1].classList.add("text-indigo-600")
  }

  itemsValidation(event) {
    event.preventDefault()
    this.finalButtonTarget.disabled = false
    this.itemsColumnTarget.classList.add("hidden")
    this.finalTextTarget.classList.remove("hidden")
    this.stepTargets[1].classList.remove("border-2")
    this.stepTargets[1].classList.add("bg-indigo-600")
    this.stepTargets[2].classList.remove("border-gray-300")
    this.stepTargets[2].classList.add("border-indigo-600")
    this.stepNumberTargets[1].classList.add("hidden")
    this.stepNumberTargets[2].classList.remove("text-gray-500")
    this.stepNumberTargets[2].classList.add("text-indigo-600")
    this.stepValidationTargets[1].classList.remove("hidden")
    this.stepTextTargets[1].classList.remove("text-indigo-600")
    this.stepTextTargets[1].classList.add("text-gray-900")
    this.stepTextTargets[1].innerText = "Items ajoutés"
    this.stepTextTargets[2].classList.remove("text-gray-500")
    this.stepTextTargets[2].classList.add("text-indigo-600")
    this.finalStepTarget.classList.add("scale")
  }
}
