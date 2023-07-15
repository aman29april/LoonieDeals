// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails";
import "./controllers";
import "./add_jquery";
import "bootstrap-tagsinput";
import "trix";
import "@rails/actiontext";
// import { application } from "./application.js";
// import * as bootstrap from "bootstrap";

import { Application } from "@hotwired/stimulus";
const application = Application.start();
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
