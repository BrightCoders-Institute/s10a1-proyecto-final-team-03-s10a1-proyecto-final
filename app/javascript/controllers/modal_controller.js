import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["trigger", "modal"]

  connect() {
    this.modalTargets.forEach(modal => {
      modal.close()
    });
  }
  
  openModal({params: { id }}){
    let modalOpened = document.getElementById(`modal-${id}`)
    modalOpened.showModal()
  }

  closeModal({params: { id }}){
    let modalClosed = document.getElementById(`modal-${id}`)
    modalClosed.close()
  }
}
