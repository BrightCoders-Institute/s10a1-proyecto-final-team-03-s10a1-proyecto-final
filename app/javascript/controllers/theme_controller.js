import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["theme_btn"];

  connect() {
    let theme = document.querySelector(".theme-light");

    let color = localStorage?.getItem("theme");
    theme.classList.add(color);

    this.changeThemeBtnContent(theme);

    this.theme_btnTarget.addEventListener("click", (e) => {
      e.preventDefault();

      theme.classList.toggle("theme-dark");
      this.changeThemeBtnContent(theme);

      let theme_color = `${
        theme.classList.contains("theme-dark") ? "theme-dark" : "theme-light"
      }`;

      localStorage.setItem("theme", `${theme_color}`);

      this.theme_btnTarget.value = `${
        theme.classList.contains("theme-dark") ? "Dark" : "Light"
      }`;
    });
  }

  changeThemeBtnContent(element) {    
    this.theme_btnTarget.innerHTML = `
      Change to
      ${element.classList.contains("theme-dark") ? "Light" : "Dark"}
      theme
    `;
  }
}
