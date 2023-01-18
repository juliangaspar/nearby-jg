import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-home"
export default class extends Controller {
  static targets = ["dragging"]

  connect() {
    this.draggingTarget.scrollIntoView({behavior:"smooth"});
  }

  nav(event) {
    // REDIRECT TO USER'S PROFILE
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
      setTimeout(
          window.location.replace(this.element.dataset.userPath)
        , 0)
      }
    // REDIRECT TO SEARCH (INDEX)
    else if ((window.scrollY) === 0) {
      setTimeout(
          window.location.replace(this.element.dataset.itemsPath)
        , 0)
      }
    }
}
