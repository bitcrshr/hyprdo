// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// assets/js/app.js
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for browser console debug logs and for hot reloading:
// >> liveSocket.enableDebug();
// >> liveSocket.enableProfiling();
// >> liveSocket.enableLatencySim(1000);
window.liveSocket = liveSocket;
