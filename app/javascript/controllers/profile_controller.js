import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "post",
    "video",
    "image_post",
    "posts",
    "images_post",
  ];

  removeActive() {
    this.postTarget.classList.remove("active");
    this.videoTarget.classList.remove("active");
    this.image_postTarget.classList.remove("active");
  }

  connect() {
    this.videoTarget.addEventListener("click", (e) => {
      e.preventDefault();
      this.removeActive(e);
      this.videoTarget.classList.add("active");
      this.postsTarget.classList.add("hidden");
      this.images_postTarget.classList.add("hidden");
    });

    this.image_postTarget.addEventListener("click", (e) => {
      e.preventDefault();
      this.removeActive(e);
      this.image_postTarget.classList.add("active");
      this.postsTarget.classList.add("hidden");
      this.images_postTarget.classList.remove("hidden");
    });

    this.postTarget.addEventListener("click", (e) => {
      e.preventDefault();
      this.removeActive(e);
      this.postTarget.classList.add("active");
      this.postsTarget.classList.remove("hidden");
      this.images_postTarget.classList.add("hidden");
    });
  }
}
