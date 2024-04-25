import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    let theme = document.querySelector(".theme-light");
    let btn_theme = document.querySelector(".theme_btn");

    let color = localStorage?.getItem("theme");
    theme.classList.add(color);

    btn_theme.addEventListener("click", (e) => {
      e.preventDefault();

      theme.classList.toggle("theme-dark");

      let theme_color = `${
        theme.classList.contains("theme-dark") ? "theme-dark" : "theme-light"
      }`;

      localStorage.setItem("theme", `${theme_color}`);

      btn_theme.value = `${
        theme.classList.contains("theme-dark") ? "Dark" : "Light"
      }`;
    });
  }
}
