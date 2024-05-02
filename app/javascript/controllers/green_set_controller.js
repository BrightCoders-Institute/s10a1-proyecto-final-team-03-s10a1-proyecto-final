import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["serie_content", "setsCheckbox"];

  connect() {
    this.setsCheckboxTargets.forEach((checkbox) => {
      checkbox.addEventListener("change", (e) => {
        e.preventDefault();
        this.serie_contentTarget.classList.toggle("green");
      });
    });
  }
}
