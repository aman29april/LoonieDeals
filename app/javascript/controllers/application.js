import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }



// import { definitionsFromContext } from "@hotwired/stimulus/webpack-helpers";
// import "dropzone/dist/min/dropzone.min.js";
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();


// import "./components";

// const context = require.context("../controllers", true, /\.js$/);
// application.load(definitionsFromContext(context));

