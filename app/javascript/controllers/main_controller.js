import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    let theme = document.querySelector(".theme-light");

    let color = localStorage?.getItem("theme");
    theme.classList.add(color);
  }
}
