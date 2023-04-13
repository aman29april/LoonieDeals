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
import "chartjs-adapter-date-fns";
import ApexCharts from "apexcharts";
// import "./utils.js";
// import './chart_custom.js'

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

 var chart = new ApexCharts(element, options);
 chart.render();



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
