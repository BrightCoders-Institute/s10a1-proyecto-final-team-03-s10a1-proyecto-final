import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["search_input", "searched"];

  async connect() {
    const response = await fetch("/search/new");
    const data = await response.json();

    const users = data.users.map((element) => {
      return [element.id, element.name];
    });

    const posts = data.posts.map((element) => {
      return [
        element.body.id,
        element.body.body.replace("<div>", "").replace("</div>", ""),
        "Post",
      ];
    });

    this.search_inputTarget.addEventListener("input", (e) => {
      e.preventDefault();

      let input_search = e.target.value;

      let filteredUser = users.filter((element) =>
        element[1].startsWith(input_search)
      );

      let filteredPost = posts.filter((element) =>
        element[1].startsWith(input_search)
      );

      const content = [...filteredPost, ...filteredUser];

      content
        ? (this.searchedTarget.innerHTML = content.map((element) =>
            element.length > 2
              ? `<a href=/posts/${element[0]}>${element[1]}</a>`
              : `<a href=/users/${element[0]}>${element[1]}</a>`
          ))
        : (this.searchedTarget.innerHTML = `<p>User or Post does not exist</p>`);
    });
  }
}
