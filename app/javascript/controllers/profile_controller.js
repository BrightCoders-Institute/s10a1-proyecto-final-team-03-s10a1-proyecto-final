import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    let video = document.querySelector(".video");
    let post = document.querySelector(".post");
    let image = document.querySelector(".image_post");
    let posts = document.querySelector(".posts");
    let images = document.querySelector(".images_post");

    video.addEventListener("click", (e) => {
      e.preventDefault();
      posts.classList.add("hidden");
      images.classList.add("hidden");
    });

    image.addEventListener("click", (e) => {
      e.preventDefault();
      posts.classList.add("hidden");
      images.classList.remove("hidden");
    });

    post.addEventListener("click", (e) => {
      e.preventDefault()
      posts.classList.remove("hidden");
      images.classList.add("hidden");
    });
  }
}
