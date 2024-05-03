import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content_u"];

  async connect() {
    const response = await fetch(
      `/users/${this.content_uTarget.dataset.userId}/edit`
    );

    const data = await response.json();

    const stories = data.stories.map((story) => {
      return [
        story.id,
        story.name.body.replace("<div>", "").replace("</div>", ""),
        story.day,
        story.images,
      ];
    });

    const cls_stories = stories.map((story) => {
      return [story[1], story[2], story[3], story[4]];
    });

    cls_stories.forEach((story, index) => {
      let img = document.createElement("img");
      let body = document.createElement("h1");
      let day = document.createElement("h3");

      if (!this.see_story(story[3])) {
        setTimeout(
          () => {
            this.contentTarget.innerHTML = "";
            body.textContent = story[2];
            day.textContent = story[3];
            img.src = story[4];

            this.contentTarget.appendChild(body);
            this.contentTarget.appendChild(day);
            this.contentTarget.appendChild(img);
          },
          index * !this.see_story(story[3]) ? 0 : 5000
        );
      }
    });
  }

  see_story = (date) => {
    let date_now = new Date();

    let filter_date = date_now.toISOString().split("T")[0];

    return filter_date > date;
  };
}
