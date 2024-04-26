import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
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

    let input = document.querySelector(".search_input");
    let content_searched = document.querySelector(".searched");

    input.addEventListener("input", (e) => {
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
        ? (content_searched.innerHTML = content.map((element) =>
            element.length > 2
              ? `<a href=/posts/${element[0]}>${element[1]}`
              : `<a href=/users/${element[0]}>${element[1]}</a>`
          ))
        : (content_searched.innerHTML = `<p>User or Post does not exist</p>`);
    });
  }
}
