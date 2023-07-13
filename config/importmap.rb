# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.js'
pin '@hotwired/stimulus', to: 'stimulus.js'
pin '@hotwired/stimulus-importmap-autoloader', to: 'stimulus-importmap-autoloader.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from File.expand_path('../app/assets/javascripts', __dir__)

# Use direct uploads for Active Storage (remember to import "@rails/activestorage" in your application.js)
pin '@rails/activestorage', to: 'activestorage.esm.js'

pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs'
pin 'just-extend', to: 'https://ga.jspm.io/npm:just-extend@6.2.0/index.esm.js'

pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
