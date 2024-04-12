import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log('Me conecté');
    this.fileField = this.element.querySelector("input[type='file']");
    this.imagePreviewContainer = document.createElement("div");
    this.imagePreviewContainer.classList.add("image-preview-container");
    this.fileField.insertAdjacentElement("afterend", this.imagePreviewContainer);
    
    this.fileField.addEventListener("change", this.previewImages.bind(this));
  }

  previewImages() {
    this.imagePreviewContainer.innerHTML = ""; // Clear preview container

    const files = this.fileField.files;

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      if (!file.type.match('image.*')) continue;

      const img = document.createElement("img");
      img.classList.add("preview-image");
      this.imagePreviewContainer.appendChild(img);

      const reader = new FileReader();
      reader.onload = (event) => {
        const originalImg = new Image();
        originalImg.onload = () => {
          const canvas = document.createElement('canvas');
          const ctx = canvas.getContext('2d');

          const maxWidth = 250; 
          const maxHeight = 250; 

          let width = originalImg.width;
          let height = originalImg.height;

          if (width > height) {
            if (width > maxWidth) {
              height *= maxWidth / width;
              width = maxWidth;
            }
          } else {
            if (height > maxHeight) {
              width *= maxHeight / height;
              height = maxHeight;
            }
          }

          canvas.width = width;
          canvas.height = height;

          ctx.drawImage(originalImg, 0, 0, width, height);
          img.src = canvas.toDataURL('image/jpeg');
        };
        originalImg.src = event.target.result;
      };
      reader.readAsDataURL(file);
    }
    console.log('Imagenes previsualizadas');
  }
}
