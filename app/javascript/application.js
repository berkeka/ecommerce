// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Tagify from "@yaireo/tagify"

window.Tagify = Tagify;
