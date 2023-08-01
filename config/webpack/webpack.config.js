const { webpackConfig } = require('shakapacker')

// module.exports = {
//     resolve: {
//         fallback: {
//             "fs": false
//         },
//     }
// }

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
// environment.plugins.append(
//   "Provide",
//   new webpack.ProvidePlugin({
//     $: "jquery",
//     jQuery: "jquery",
//     Popper: ["popper.js", "default"], // Not a typo, we're still using popper.js here
//   })
// );
module.exports = webpackConfig
