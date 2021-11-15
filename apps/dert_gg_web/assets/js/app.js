// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html";
import Bowser from "bowser";

const URL = document.URL;
const EXTENSION_ID = "dmcpeogfmcmenjadndfjhafnbhpabffn";

if (URL.includes("token")) {
  let browser = Bowser.getParser(window.navigator.userAgent);
  let browserName = browser.getBrowser().name;

  if (browserName == 'Chrome') {
    let token = extractToken(URL);
    sendTokenToExtension(EXTENSION_ID, token);
  } else {
    console.log("unsupported browser type");
  }
}

function extractToken(url) {
  let index = url.indexOf("token=");
  let token = url.substring(index + 6);
  return token;
}

function sendTokenToExtension(extensionId, token) {
  chrome.runtime.sendMessage(extensionId, {token: token},
    function(response) {
      if (!response.success) {
        console.log("Something went wrong!");
      }
    }
  );
}
