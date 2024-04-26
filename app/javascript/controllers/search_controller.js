import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async connect() {
    const response = await fetch("/search/new");
    const data = await response.json();

    const users = data.users.map((element) => {
      return element.name;
    });

    const posts = data.posts.map((element) => {
      return element.body.body.replace("<div>", "").replace("</div>", "");
    });

    let input = document.querySelector(".search_input");
    let content_searched = document.querySelector(".searched");

    input.addEventListener("input", (e) => {
      e.preventDefault();

      let input_search = e.target.value;

      let filteredUser = users.filter((element) =>
        element.startsWith(input_search)
      );

      let filteredPost = posts.filter((element) =>
        element.startsWith(input_search)
      );

      const content = [...filteredPost, ...filteredUser];

      content
        ? (content_searched.innerHTML = content.map(
            (element) => `<p>${element}</p>`
          ))
        : (content_searched.innerHTML = `<p>User or Post does not exist</p>`);
    });
  }
}
