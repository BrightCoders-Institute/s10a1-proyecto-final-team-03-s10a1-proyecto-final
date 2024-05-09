import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content_u", "user"];

  async connect() {
    const response = await fetch(`/users/1/json`);

    const data = await response.json();

    let user_id = this.userTarget.dataset.userId;

    const stories = data.stories.map((story) => {
      return [
        story.user_id,
        story.id,
        story.name.body.replace("<div>", "").replace("</div>", ""),
        story.day,
        story.images,
      ];
    });

    let cls_stories = [];

    stories.map((story) => {
      if (story[0] == user_id) {
        cls_stories.push([...story]);
      }
    });

    cls_stories.forEach((story, index) => {
      let img = document.createElement("img");
      let body = document.createElement("h1");
      let day = document.createElement("h3");

      if (this.see_story(story[3])) {
        setTimeout(
          () => {
            this.content_uTarget.innerHTML = "";
            body.textContent = story[2];
            day.textContent = story[3];
            img.src = story[4];
            img.width = 300;
            img.height = 300;
            img.alt = "No image";

            this.content_uTarget.appendChild(body);
            this.content_uTarget.appendChild(day);
            this.content_uTarget.appendChild(img);
          },
          index * this.see_story(story[3]) ? 0 : 5000
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
