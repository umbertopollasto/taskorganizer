import { Application } from "@hotwired/stimulus"
import * as User from "./users_controller"
import * as hello from "./hello_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
