import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  async connect() {
    const response = await fetch("/stories/show");

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
      return [story[0], story[1], story[2], story[3]];
    });

    cls_stories.forEach((story, index) => {
      let img = document.createElement("img");
      let body = document.createElement("h1");
      let day = document.createElement("h3");

      console.log(story);

      if (!this.see_story(story[2])) {
        setTimeout(() => {
          this.contentTarget.innerHTML = "";
          body.textContent = story[1];
          day.textContent = story[2];
          img.src = story[3];

          this.contentTarget.appendChild(body);
          this.contentTarget.appendChild(day);
          this.contentTarget.appendChild(img);
        }, index * 5000);
      }
    });
  }

  see_story = (date) => {
    let date_now_utc = new Date();

    let offset_minutes = date_now_utc.getTimezoneOffset();

    let offset_ms = offset_minutes * 60 * 1000;

    let date_now_local = new Date(date_now_utc.getTime() - offset_ms);

    let filter_date = date_now_local.toISOString().split("T")[0];

    console.log(filter_date > date);
    return filter_date > date;
  };
}
