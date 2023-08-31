import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
import { Dropzone } from "dropzone";
import Sortable from "sortablejs";
import { getMetaValue, findElement, removeElement } from "../helpers";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.dropZone = this.createDropZone(this);
    this.hideFileInput();
    this.bindEvents();
    Dropzone.autoDiscover = false;
    document.dropZone = this.dropZone;

    var _this = this.dropZone;
    // setTimeout(() => {
      this.existingFiles.forEach((image) => {
        // debugger
        let mockFile = {
          name: image.name,
          size: parseInt(image.size),
          dataURL: image.url,
          accepted: true,
          kind: "image",
          // id: "1",
        };

        // this.files.push(mockFile);
        // this.emit("addedfile", mockFile);

        // await imageData = toDataURL(image);
        // this.toDataURL(image).then(dataUrl => {
        //   // this.files.push(dataUrl);
        //   // this.emit("addedfile", dataUrl);
        //   this.createThumbnail(dataUrl);
        // })
        // this.createThumbnail(imageData)
        // this.createThumbnailFromUrl(
        //   mockFile,
        //   // this.options.thumbnailWidth,
        //   // this.options.thumbnailHeight,
        //   // this.options.thumbnailMethod,
        //   true,
        //   (thumbnail) => {
        //     this.emit("thumbnail", mockFile, thumbnail);
        //     this.emit("complete", mockFile);
        //   }
        // );

        // _this.files.push(mockFile);

        _this.emit("addedfile", mockFile);

        _this.createThumbnailFromUrl(
          mockFile,
          _this.options.thumbnailWidth,
          _this.options.thumbnailHeight,
          _this.options.thumbnailMethod,
          true,
          function (dataUrl) {
            // _this.emit("thumbnail", mockFile, dataUrl);
            _this.emit("thumbnail", mockFile, dataUrl);

            _this.emit("success", mockFile, image);
            _this.emit("complete", mockFile);
            // document.dropZone.emit("thumbnail", mockFile, dataUrl);
            // document.dropZone.emit("complete", mockFile);
          },
          "anonymous"
        );


        // this.emit("complete", mockFile);
      });
      _this.options.maxFiles =
        _this.options.maxFiles - this.existingFiles.count;
    // }, 500);
    // Sortable.create(this.dropZone, {
    //  });
  }

  // Private
  hideFileInput() {
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = "none";
  }

  bindEvents() {
    this.dropZone.on("addedfile", (file) => {
      setTimeout(() => {
        file.accepted && this.createDirectUploadController(this, file).start();
      }, 500);
    });

    this.dropZone.on("removedfile", (file) => {
      file.controller && removeElement(file.controller.hiddenInput);
    });

    this.dropZone.on("canceled", (file) => {
      file.controller && file.controller.xhr.abort();
    });

    // document.onpaste = function (event) {
    //   const items = (event.clipboardData || event.originalEvent.clipboardData).items;
    //   for (const item of items) {
    //     if (item.kind === "file" && item.type.includes("image")) {
    //       this.dropZone.addFile(item.getAsFile());
    //     }
    //   }
    // }
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 1;
  }

  get existingFiles() {
    return JSON.parse(this.data.get("existingFiles"))|| [];
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get previewsContainer() {
    return this.data.get("previewsContainer") || '.dropzone-previews';
  }

  get dictFileTooBig() {
    return (
      this.data.get("dictFileTooBig") ||
      "File sile is {{filesize}} but only files up to {{maxFilesize}} are allowed"
    );
  }

  get dictInvalidFileType() {
    return this.data.get("dictInvalidFileType") || "Invalid file type";
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }


  get clickable() {
    return this.data.get("clickable") || '.dz-clickable';
  }

  createDirectUploadController(source, file) {
    return new DirectUploadController(source, file);
  }

  createDropZone(controller) {
    return new Dropzone(controller.element, {
      url: controller.url,
      headers: controller.headers,
      maxFiles: controller.maxFiles,
      maxFilesize: controller.maxFileSize,
      dictFileTooBig: controller.dictFileTooBig,
      dictInvalidFileType: controller.dictInvalidFileType,
      acceptedFiles: controller.acceptedFiles,
      addRemoveLinks: controller.addRemoveLinks,
      dictRemoveFile: "Remove",
      dictCancelUpload: "Cancel",
      dictRemoveFileConfirmation: "Are you sure?",
      previewsContainer: controller.previewsContainer,
      // thumbnailHeight: 42,
      // thumbnailWidth: 44,
      clickable: controller.clickable,
      autoQueue: false,
      init: function () {
        // Handle pasted images
        document.addEventListener("paste", (event) => {
          const items = (
            event.clipboardData || event.originalEvent.clipboardData
          ).items;
          for (const item of items) {
            if (item.type.indexOf("image") !== -1) {
              const blob = item.getAsFile();

              this.addFile(blob);
            }
          }
        });

        this.on("success", function (file, response) {
          // var remove_button = Dropzone.createElement("<button>Delete</button>");
          // var _this = this;
          //  remove_button.addEventListener("click", function (e) {
          //    e.preventDefault();
          //    e.stopPropagation();
          //    file.controller && removeElement(file.controller.hiddenInput);
          //   //  fetch(response.path, {
          //   //    method: "delete",
          //   //  }).then(function (_) {
          //   //    _this.removeFile(file);
          //   //  });
          //  });
          // file.previewElement.appendChild(remove_button);
          // var filename_node =
          //   file.previewTemplate.getElementsByClassName("dz-filename")[0]
          //     .childNodes[0];
          // // filename_node.textContent = `![](/images/${response.filename})`;
        });
      },
    });
  }

  createThumbnail(temp) {
    this.myDropzone.createThumbnailFromUrl(
      temp,
      this.myDropzone.options.thumbnailWidth,
      this.myDropzone.options.thumbnailHeight,
      this.myDropzone.options.thumbnailMethod,
      true,
      function (thumbnail) {
        this.myDropzone.emit("thumbnail", temp, thumbnail);
        this.myDropzone.emit("complete", temp);
      }
    );
  }
  
  toDataURL = url => fetch(url)
  .then(response => response.blob())
  .then(blob => new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.onloadend = () => resolve(reader.result)
    reader.onerror = reject
    reader.readAsDataURL(blob)
  }))
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = this.createDirectUpload(file, source.url, this);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if (error) {
        removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
      }
    });
  }

  createHiddenInput() {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    this.insertAfter(input, this.source.inputTarget);
    return input;
  }

  insertAfter(el, referenceNode) {
    return referenceNode.parentNode.insertBefore(el, referenceNode.nextSibling);
  }

  removeElement(el) {
    if (el && el.parentNode) {
      el.parentNode.removeChild(el);
    }
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr);
    this.emitDropzoneUploading();
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", (event) =>
      this.uploadRequestDidProgress(event)
    );
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  findElement(root, selector) {
    if (typeof root == "string") {
      selector = root;
      root = document;
    }
    return root.querySelector(selector);
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file);
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error);
    this.source.dropZone.emit("complete", this.file);
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file);
    this.source.dropZone.emit("complete", this.file);
  }

  createDirectUpload(file, url, controller) {
    return new DirectUpload(file, url, controller);
  }
}
