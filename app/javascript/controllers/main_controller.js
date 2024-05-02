import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["themelight"];

  connect() {
    let color = localStorage?.getItem("theme");
    this.themelightTarget.classList.add(color);
  }
}
