// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails";
import "./controllers";
import "./add_jquery";
import "bootstrap-tagsinput";
import "trix";
import "@rails/actiontext";
import ClipboardJS from "clipboard";

import "./components"

import { Application } from "@hotwired/stimulus";
import { debug } from "webpack";
const application = Application.start();
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// Support component names relative to this directory:
// var componentRequireContext = require.context("components", true);
// var ReactRailsUJS = require("react_ujs");
// ReactRailsUJS.useContext(componentRequireContext);

// document.addEventListener("turbo:load", (event) => {
$(document).jquery(function () {
  debugger
  var clipboard = new ClipboardJS(".js-clipboard", {
    text: function (trigger) {
      return trigger.getAttribute("data-clipboard-text");
    },
  });

  clipboard.on("success", function (e) {
    console.info("Action:", e.action);
    console.info("Text:", e.text);
    console.info("Trigger:", e.trigger);

    e.clearSelection();
  });
});
