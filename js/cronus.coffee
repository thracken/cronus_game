#Player Stat Items
class TeamMember
  constructor: (@name) ->
    @str = 1
    @fort = 1
    @dex = 1
    @speed = 1
    @energy = 20

    @hp = ->
      @fort * 10
    @crit_dmg = ->
      1 + ((@dex + @str)/100)
    @base_dmg = ->
      @str * 1.5
    @armor = ->
      @fort * 0.5
    @crit_chance = ->
      (@dex/100)
    @dodge = ->
      1 + ((@speed+@dex)/100)


#Story Items
class StorySegment
  constructor: (@num, @name, @images) ->
    #unlock = ->
    x = 0
    @show = ->
      html = "<div id='story-segment-1' class='container-fluid modal fade'>"+"
        <div class='modal-dialog modal-lg' role='document'>"+"
          <div class='modal-content'>"+"
            <div class='modal-header'>"+"
              <button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"+"
              <h4 class='modal-title' id='myModalLabel'>" + @num + " - " + @name + "</h4>"+"
            </div>"+"
            <div class='modal-body'>"+"
              <img class='story-image' src=" + @images[x] + " class='row' />"+"
            </div>"+"
            <div class='modal-footer'>"+"
            </div>"+"
          </div>"+"
        </div>"+"
      </div>"
      $('body').append(html)
      $('#story-segment-1').modal "show"

segment1 = new StorySegment(1, "Let's get out of here...", ["img/tube1.jpg","img/tubes.png"])


#General Functions
first_launch = ->
  true

first_run = ->
  if first_launch
    segment1.show()


#Run on page load
$(document).ready ->
  first_run()

###
  window.setInterval( ->

  , 1000)

StorySegment
TeamMember
Mission
Achievement
Currency
960x430 is standard size for main_image
960x430 = 900
###
