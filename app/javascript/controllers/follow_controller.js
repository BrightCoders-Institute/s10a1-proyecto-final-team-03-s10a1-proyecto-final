import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const followbtn = document.querySelector(".follow");
    const unfollowbtn = document.querySelector(".unfollow");

    unfollowbtn.classList.add("hidden");

    followbtn.addEventListener("click", (e) => {
      e.preventDefault();
      followbtn.classList.add("hidden");
      unfollowbtn.classList.remove("hidden");
      this.toggleFollow(".form-u", true);
    });

    unfollowbtn.addEventListener("click", (e) => {
      e.preventDefault();
      unfollowbtn.classList.add("hidden");
      followbtn.classList.remove("hidden");
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
