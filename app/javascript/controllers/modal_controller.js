import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    document.addEventListener('click', this.closeModal.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.closeModal.bind(this))
  }

  openModal() {
    this.modalTarget.classList.toggle("hidden")
  }

  closeModal(event) {
    const modal = this.modalTarget

    const lossFocus = modal.contains(event.target)
    const isModalTrigger = event.target.closest(".bi-three-dots-vertical")

    if (!lossFocus && !isModalTrigger) {
      modal.classList.add("hidden")
    }
  }
}
