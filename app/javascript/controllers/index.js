// Import and register all your controllers from the importmap under controllers/*

// import "./controllers";
// import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
import Chart from "chart.js/auto";
import { Tooltip } from "chart.js/auto";

import "chartjs-adapter-date-fns";
import ApexCharts from "apexcharts";
import "./utils.js";
import './chart_custom.js'
import "./popper_controller.js";
import "./tooltip_controller.js";

var element = document.getElementById("chart");
var data = JSON.parse(element.dataset.data);

 var options = {
   series: [
     {
       name: "$",
       data: data,
     },
   ],
   chart: {
     type: "area",
     stacked: false,
     height: 350,
     zoom: {
       type: "x",
       enabled: false,
       autoScaleYaxis: true,
     },
     toolbar: {
       autoSelected: "zoom",
     },
   },
   dataLabels: {
     enabled: false,
   },
   markers: {
     size: 0,
   },
  //  title: {
  //    text: "Stock Price Movement",
  //    align: "left",
  //  },
   fill: {
     type: "gradient",
     gradient: {
       shadeIntensity: 1,
       inverseColors: false,
       opacityFrom: 0.5,
       opacityTo: 0,
       stops: [0, 90, 100],
     },
   },
   yaxis: {
     labels: {
       formatter: function (val) {
         return (val / 1000000).toFixed(0);
       },
     },
     title: {
       text: "Price",
     },
   },
   xaxis: {
     type: "datetime",
     formatter: function (val) {
       return new Date(val).getTime();
     },
   },
   tooltip: {
     shared: false,
     y: {
       formatter: function (val) {
         return (val / 100).toFixed(2);
       },
     },
   },
 };

//  var chart = new ApexCharts(element, options);
//  chart.render();


  function getRawDatasetsFromDom() {
    var element = document.getElementById("chart");
    var data = JSON.parse(element.dataset.data);

    return [
      {
        data: data,
      },
    ];

    return [
      {
        metric: "Price",
        label: "Price on BSE",
        values: data,
        meta: {
          exchange: "bse",
          unit: "month",
        },
      },
    ];
  }


  function getChartOptions() {
    var options = {
      hover: {
        animationDuration: 0, // disable animation on hover
      },
      maintainAspectRatio: false,
      scales: {
        x: {
          type: "timeseries",
          // offset and grid-offset is set to false
          // because bar-charts set it true by default
          offset: false,
          time: {
            tooltipFormat: "MMM yyyy",
            displayFormats: {
              year: "MMM yyyy",
              // day: "d MMM",
            },
          },
          ticks: {
            autoSkip: true,
            autoSkipPadding: 50,
            display: true,
            maxRotation: 0,
          },
          grid: {
            display: true,
            drawOnChartArea: false,
            drawTicks: true,
            offset: false,
          },
        },
      },
      interaction: {
        // pick nearest value for datasets on x axis
        mode: "index",
        axis: "x",
        // intersection of mouse is not required.
        // Always show hover points and tooltips
        intersect: false,
      },
      plugins: {
        
        legend: {
          display: false,
        },
      },
    };
    return options;
  }

    

  // // add custom tooltip mode to ChartJS
  //   Tooltip.positioners.setCustomTooltipPosition = function (
  //     elements,
  //     eventPosition
  //   ) {
  //     var tooltipModel = this;
  //     // default elements is elements used by Chart.js
  //     return setCustomTooltipPosition(
  //       tooltipModel,
  //       tooltipElements,
  //       eventPosition
  //     );
  //   };


    function getTooltipElements() {
      return {
        tooltipEl: document.getElementById("chart-tooltip"),
        titleEl: document.getElementById("chart-tooltip-title"),
        infoEl: document.getElementById("chart-tooltip-info"),
        metaEl: document.getElementById("chart-tooltip-meta"),

        crossHair: document.getElementById("chart-crosshair"),
        customInfo: document.getElementById("chart-info"),
        // dateFormatter: Utils.dateFormatter({
        //   month: "short",
        //   day: "numeric",
        //   year: "numeric",
        // }),
      };
    }

 // draw chart
// var target = document.getElementById("canvas-chart-holder");
//     var canvas = document.createElement("canvas");
// target.appendChild(canvas);

//     var tooltipElements = getTooltipElements();
// var options = getChartOptions();
    
// debugger
// // var ctx = canvas.getContext("2d");
//     var ctx = document.getElementById("my-canvas").getContext("2d");
//     var chart = new Chart(ctx, {
//       type: "line",
//       data: {
//         datasets: getRawDatasetsFromDom(),
//       },
//       options: options,
//     });



// var ctx = document.getElementById("myChart").getContext("2d");
// var myChart = new Chart(ctx, {
//   type: "line",
//   data: {
//     labels: JSON.parse(ctx.canvas.dataset.labels),
//     datasets: [
//       {
//         data: JSON.parse(ctx.canvas.dataset.data),
//       },
//     ],
//   },
// });

// document.addEventListener("turbolinks:load", () => {
  
//   var ctx = document.getElementById("myChart").getContext("2d");
//   var myChart = new Chart(ctx, {
//     type: "line",
//     data: {
//       labels: JSON.parse(ctx.canvas.dataset.labels),
//       datasets: [
//         {
//           data: JSON.parse(ctx.canvas.dataset.data),
//         },
//       ],
//     },
//   });
// });
