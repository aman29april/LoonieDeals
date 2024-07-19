// background.js
chrome.action.onClicked.addListener((tab) => {
  chrome.scripting.executeScript({
    target: { tabId: tab.id },
    function: scrapePage,
  });
});

function scrapePage() {
  // Write your scraping logic here
}

function postData() {
  // Extract scraped data
  let { titles, paragraphs } = message.data;

  // Construct payload for API request
  let payload = { titles, paragraphs };

  // Send API request to save data
  fetch("https://example.com/api/data", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  })
    .then((response) => response.json())
    .then((data) => console.log("Data saved:", data))
    .catch((error) => console.error("Error saving data:", error));
}
// background.js

// Listen for messages from content script
chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'scrapeData') {
    // postData();
  }
});
