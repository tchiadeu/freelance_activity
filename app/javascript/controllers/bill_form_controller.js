import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "items", "clientInput", "clientsAttributes", "clientForm", "newItemBtn", "newClientBtn", "newClientConfirmation" ]
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
        this.clientFormTarget.innerHTML = `
         <label for="bill_client_attributes_name">Nom</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${clientSelected.value}">
         <label for="bill_client_attributes_address">Address</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${address}">
         <label for="bill_client_attributes_post_code">Code Postal</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${postCode}">
         <label for="bill_client_attributes_city">Ville</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${city}">
         <label for="bill_client_attributes_siret_number">SIRET</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${siretNumber}">
         <label for="bill_client_attributes_tva_number">Numéro de TVA</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${tvaNumber}">
         <label for="bill_client_attributes_email">Email</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${email}">
         <label for="bill_client_attributes_phone_number">Téléphone</label>
         <input id="bill_client_attributes_name" name="bill[client_attributes][name]" type="text" value="${phoneNumber}">
        `
      }
    })
    this.clientFormTarget.classList.remove("hidden")
    this.newItemBtnTarget.classList.remove("hidden")
    this.newClientBtnTarget.classList.add("hidden")
    this.clientInputTarget.classList.add("hidden")
  }

  addClient(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.clientInputTarget.classList.add("hidden")
    this.clientFormTarget.classList.remove("hidden")
    this.newClientConfirmationTarget.classList.remove("hidden")
  }

  newClientConfirmation(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.newItemBtnTarget.classList.remove("hidden")
  }
}
