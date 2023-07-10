import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus/webpack-helpers";
import "dropzone/dist/min/dropzone.min.js";
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();



const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import "./components";

const context = require.context("../controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

document.addEventListener("turbolinks:load", () => {
  console.log("ok");
  var ctx = document.getElementById("myChart").getContext("2d");
  var myChart = new Chart(ctx, {
    type: "line",
    data: {
      labels: JSON.parse(ctx.canvas.dataset.labels),
      datasets: [
        {
          data: JSON.parse(ctx.canvas.dataset.data),
        },
      ],
    },
  });
});
