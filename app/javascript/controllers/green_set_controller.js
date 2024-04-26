import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const checkboxes = document.querySelectorAll('.setsCheckbox input[type="checkbox"]');
    const divs = document.querySelectorAll('.serie_content');

    checkboxes.forEach((checkbox, index) => {
        checkbox.addEventListener('change', function() {
            if (this.checked) {
                divs[index].classList.add('green');
            } else {
                divs[index].classList.remove('green');
            }
        });
    });
  }
}
