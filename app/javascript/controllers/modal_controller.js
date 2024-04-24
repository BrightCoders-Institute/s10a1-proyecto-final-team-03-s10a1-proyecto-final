import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    const triggerButtons = document.querySelectorAll(".btn__modal")

    triggerButtons.forEach((button) => {
      let id = button.getAttribute("data-target").split("-")[1]
      let modal = document.getElementById(`modal-${id}`)

      button.addEventListener("click", () => {
        console.log(button + " clicked");
        modal.showModal()
        modal.focus()
      })

      modal.addEventListener("click", modal.close)
    })
  }
}
