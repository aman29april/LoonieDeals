// popup.js
// Function to scroll the page
function scrollPage() {
  window.scrollBy(0, window.innerHeight); // Scroll down by the height of the viewport
}

// Function to scroll the page slowly
function scrollPageSlowly() {
  const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
  const scrollStep = 20; // Adjust the step size as needed
  const scrollInterval = 20; // Adjust the interval time (in milliseconds) as needed

  let scrollTop = 0;

  // Define the scroll function
  function scroll() {
    scrollTop += scrollStep;
    window.scrollTo(0, scrollTop);

    // Check if reached the bottom of the page
    if (scrollTop < scrollHeight) {
      // Continue scrolling
      setTimeout(scroll, scrollInterval);
    }
  }

  // Start scrolling
  scroll();
}

document.addEventListener('DOMContentLoaded', function () {
  document
    .getElementById("scrapeButton")
    .addEventListener("click", async () => {
      let [tab] = await chrome.tabs.query({
        active: true,
        currentWindow: true,
      });
      
      chrome.scripting.executeScript({
        target: { tabId: tab.id },
        function: () => {
          function scrollPageSlowly() {
            const scrollHeight =
              document.documentElement.scrollHeight - window.innerHeight;
            const scrollStep = 30; // Adjust the step size as needed
            const scrollInterval = 20; // Adjust the interval time (in milliseconds) as needed

            let scrollTop = 0;

            // Define the scroll function
            function scroll() {
              scrollTop += scrollStep;
              window.scrollTo(0, scrollTop);

              // Check if reached the bottom of the page
              if (scrollTop < scrollHeight) {
                // Continue scrolling
                setTimeout(scroll, scrollInterval);
              }
            }

            // Start scrolling
            scroll();
          }

          // Function to trigger the onmouseover event
          function triggerOnHover(element) {
            // Create a new mouseover event
            const event = new MouseEvent("mouseover", {
              bubbles: true, // Allow event to bubble up through the DOM
              cancelable: true, // Allow event to be canceled
              view: window, // Specify the window as the event view
            });

            // Dispatch the mouseover event on the element
            element.dispatchEvent(event);
          }

          // Function to trigger the mousemove event
          function triggerMouseMove(element) {
            // Create a new mousemove event
            const event = new MouseEvent("mousemove", {
              bubbles: true, // Allow event to bubble up through the DOM
              cancelable: true, // Allow event to be canceled
              view: window, // Specify the window as the event view
              clientX: 0, // X coordinate of the mouse pointer relative to the viewport
              clientY: 0, // Y coordinate of the mouse pointer relative to the viewport
            });

            // Dispatch the mousemove event on the element
            element.dispatchEvent(event);
          }

          // Function to trigger the focus event
          function triggerFocus(element) {
            // Create a new focus event
            const event = new FocusEvent("focus", {
              bubbles: true, // Allow event to bubble up through the DOM
              cancelable: true, // Allow event to be canceled
              view: window, // Specify the window as the event view
            });

            // Dispatch the focus event on the element
            element.dispatchEvent(event);
          }

          function scrapPage() {
            const htmlContent = document.documentElement.outerHTML;
            const doc = new DOMParser().parseFromString(
              htmlContent,
              "text/html"
            );

            scriptTag = null;
            // Get all elements with the data-content-len attribute
            const elementsWithDataContentLen =
              doc.querySelectorAll("[data-content-len]");

            // Iterate through each element
            elementsWithDataContentLen.forEach((element) => {
              // Get the value of the data-content-len attribute as a number
              const contentLenValue = parseInt(
                element.getAttribute("data-content-len")
              );

              // Check if the value is greater than 200
              if (
                !isNaN(contentLenValue) &&
                contentLenValue > 100000 &&
                element.text.contains("ExternalWebLink")
              ) {
                // Log or do something with the element
                console.log(element);
                scriptTag = element;

                scriptTag.text;

                JSON.parse(scriptTag.text);
              }
            });

            const post_titles = document.querySelectorAll(
              'div[data-ad-comet-preview="message"]'
            );

            data = [];
            let images;
            post_titles.forEach((titleDiv) => {
              let postDiv = titleDiv.parentNode.parentNode;

              let title = titleDiv.innerText;
              // const textDivs = titleDiv.querySelectorAll(
              //   'div[style="text-align: start;"]'
              // );
              let anchorTags = postDiv.querySelectorAll("a");
              images = postDiv.querySelectorAll("img");

              if (anchorTags.length === 0) {
                return;
              }

              images.forEach((image) => {
                triggerOnHover(image.parentNode);
              });

              link = anchorTags[0];
              triggerMouseMove(link.parentNode);
              triggerOnHover(link);
              triggerFocus(link);

              setTimeout(() => {
                ariaLabelValue = link.getAttribute("aria-label");
                url = link.href;
                image = "";
                if (
                  url === "https://www.facebook.com/groups/706807839874991#"
                ) {
                  // debugger
                  console.log("issueee...");
                }

                let postData = {
                  url: url,
                  linkText: ariaLabelValue,
                  title: title,
                  image: image,
                };
                data.push(postData);
              }, 1000);
            });

            console.log(data);
            // let regexPattern = /example\.com\/article\/\d+/; // Example regex pattern
            // let links = extractLinks(regexPattern);

            return data;
          }

          // scrollPageSlowly();
          scrapPage();
        }
      });
    });
})



// Function to scrape HTML content


// function scrapePage() {
//   // Write your scraping logic here
// }
