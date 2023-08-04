// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CropperController from "./cropper_controller"
application.register("cropper", CropperController)

import DragController from "./drag_controller"
application.register("drag", DragController)

import DropzoneController from "./dropzone_controller"
application.register("dropzone", DropzoneController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PopperController from "./popper_controller"
application.register("popper", PopperController)

import SlimController from "./slim_controller"
application.register("slim", SlimController)

import TooltipController from "./tooltip_controller"
application.register("tooltip", TooltipController)
