import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    console.log(event)
    let id = event.item.dataset.id
    let url = this.data.get("url").replace(":id", id)
    let data = new FormData()
    data.append('position', event.newIndex + 1);
    Rails.ajax({
      url: url,
      type: 'PATCH',
      data: data
    })
  }
}
