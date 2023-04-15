import { createPopper } from "@popperjs/core";
import * as bootstrap from "bootstrap";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    var popoverTriggerList = [].slice.call(
      document.querySelectorAll('[data-bs-toggle="popover"]')
    );
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
      return new bootstrap.Popover(popoverTriggerEl);
    });
  }
}
