import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["clapCount"]

  addClap(event) {
    event.preventDefault()

    this.clapCountTarget.innerHTML = "Ky"
  }
}
