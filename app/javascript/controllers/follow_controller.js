import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["follow", "unfollow"];

  connect() {
    this.unfollowTarget.classList.add("hidden");

    this.followTarget.addEventListener("click", (e) => {
      e.preventDefault();
      this.followTarget.classList.toggle("hidden");
      this.unfollowTarget.classList.toggle("hidden");
      this.toggleFollow(".form-u", true);
    });

    this.unfollowTarget.addEventListener("click", (e) => {
      e.preventDefault();
      this.unfollowTarget.classList.toggle("hidden");
      this.followTarget.classList.toggle("hidden");
      this.toggleFollow(".form-f", true);
    });
  }

  toggleFollow(formSelector, reloadPage) {
    const form = document.querySelector(formSelector);

    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
    })
      .then((response) => {
        if (response.ok) {
          console.log("Formulario enviado con éxito");
          if (reloadPage) {
            location.reload();
          }
        } else {
          console.error("Error al enviar el formulario");
        }
      })
      .catch((error) => {
        console.error("Error de red:", error);
      });
  }
}
