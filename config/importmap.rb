# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
pin '@hotwired/turbo-rails', to: 'turbo.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

# pin_all_from File.expand_path('../app/assets/javascripts', __dir__)

# Use direct uploads for Active Storage (remember to import "@rails/activestorage" in your application.js)
# pin '@rails/activestorage', to: 'activestorage.esm.js'

# pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs'
pin 'just-extend', to: 'https://ga.jspm.io/npm:just-extend@6.2.0/index.esm.js'

# pin 'trix'
# pin '@rails/actiontext', to: 'actiontext.js'
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.6/lib/assets/compiled/rails-ujs.js'
pin 'react', to: 'https://ga.jspm.io/npm:react@18.2.0/index.js'
# pin "slim-select", to: "https://ga.jspm.io/npm:slim-select@2.6.0/dist/slimselect.es.js", preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
