import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  removeActive() {
    const profileSections = document.querySelector(".profile-sections");
    const active = profileSections.querySelector(".active");
    active.classList.remove("active");
  }
  
  connect() {
    let video = document.querySelector(".video");
    let post = document.querySelector(".post");
    let image = document.querySelector(".image_post");
    let posts = document.querySelector(".posts");
    let images = document.querySelector(".images_post");

    video.addEventListener("click", (e) => {
      e.preventDefault();
      this.removeActive();
      video.classList.add("active");
      posts.classList.add("hidden");
      images.classList.add("hidden");
    });

    image.addEventListener("click", (e) => {
      e.preventDefault();
      this.removeActive();
      image.classList.add("active");
      posts.classList.add("hidden");
      images.classList.remove("hidden");
    });

    post.addEventListener("click", (e) => {
      e.preventDefault()
      this.removeActive();
      post.classList.add("active");
      posts.classList.remove("hidden");
      images.classList.add("hidden");
    });
  }
}
