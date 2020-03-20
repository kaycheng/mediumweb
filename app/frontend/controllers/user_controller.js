import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = ["followButton", "bookmark"]

  follow(event) {
    event.preventDefault()
    let user = this.followButtonTarget.dataset.user
    let button = this.followButtonTarget
    
    axios.post(`/api/users/${user}/follow`)
         .then(function (response) {
           let status = response.data.status
           switch (status) {
             case 'sign_in_first':
               alert('Sign in first!!')
               break;
             default:
               button.innerHTML = status
               break;
           }
         })
         .catch(function (error) {
           console.log(error)
         })
  
  }

  addBookmark(event) {
    event.preventDefault()
    let link = event.currentTarget
    let slug = link.dataset.slug

    // /api/stories/:id/bookmark
    axios.post(`/api/stories/${slug}/bookmark`)
         .then(function(response) {
           console.log(response.data)
         })
         .catch(function(error) {
           console.log(error)
         })
  }
} 