puts "Coffeescript compiled" if system "coffee -cb js/cronus.coffee"
puts "Sass compiled" if system "sass css/style.scss css/style.css"
