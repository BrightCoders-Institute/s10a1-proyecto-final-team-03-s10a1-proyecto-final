import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  connect() {
    const dateValue = new Date();
    const year = dateValue.getFullYear();
    const month = dateValue.getMonth() + 1;
    const day = dateValue.getDate();

    const formattedDate = `${year}-${month.toString().padStart(2, "0")}-${day
      .toString()
      .padStart(2, "0")}`;

    this.fieldTarget.value = formattedDate;
  }
}
