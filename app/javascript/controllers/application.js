import { Application } from "@hotwired/stimulus"
import * as User from "./users_controller"
import * as hello from "./hello_controller"
import * as Select2 from "./select_custom"

console.log($)
const application = Application.start()
// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
