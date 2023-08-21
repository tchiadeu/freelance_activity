import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "items", "clientInput", "clientsAttributes", "clientForm", "newItemBtn", "newClientBtn",
    "newClientConfirmation", "submit", "clientName", "clientAddress", "clientPostCode", "step",
    "clientCity", "clientSiretNumber", "clientTvaNumber", "clientEmail", "clientPhoneNumber",
    "formContainer", "instructions"
  ]
  currentIndex = -1

  addItem(event) {
    event.preventDefault()
    this.currentIndex++
    this.itemsTargets[this.currentIndex].classList.remove("hidden")
    event.currentTarget.innerText = "Ajouter un autre article"
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
    this.clientFormTarget.classList.remove("hidden")
    this.newItemBtnTarget.classList.remove("hidden")
    this.newClientBtnTarget.classList.add("hidden")
    this.clientInputTarget.classList.add("hidden")
    this.submitTarget.classList.remove("hidden")
    this.stepTarget.innerText = "Etape 2/2"
    this.formContainerTarget.classList.remove("sm:max-w-sm")
    this.instructionsTargets.forEach((instruction) => {
      instruction.classList.add("hidden")
    })
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
    this.newItemBtnTarget.classList.remove("hidden")
    this.submitTarget.classList.remove("hidden")
    this.stepTarget.innerText = "Etape 2/2"
    this.formContainerTarget.classList.remove("sm:max-w-sm")
  }
}
