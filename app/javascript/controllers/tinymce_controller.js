import tinymce from "tinymce/tinymce";
import "tinymce/icons/default/icons";
import "tinymce/themes/silver/theme";
import "tinymce/skins/ui/oxide/skin.min.css";
import "tinymce/models/dom";

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tinymce"
export default class extends Controller {
  connect() {
    tinymce.init({
      selector: "textarea", // change this value according to your HTML
    });
  }

  disconnect() {
    tinymce.remove();
  }
}
