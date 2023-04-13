import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import Chart from "chart.js/auto";

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
