
function backgroundMethod() {
  console.log("extension loaded....")
}
// Function to extract links from anchor elements that match the regex pattern
function extractLinks(regexPattern) {
  let links = Array.from(document.querySelectorAll('a'))
    .map(a => a.href)
    .filter(href => regexPattern.test(href)); // Filter links based on regex pattern
  return links;
}

// Send scraped data to background script
chrome.runtime.sendMessage({
  action: "backgroundMethod",
  data: backgroundMethod(),
});
