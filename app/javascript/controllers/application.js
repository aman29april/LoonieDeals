import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus/webpack-helpers";


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import Chart from "chart.js/auto";

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
