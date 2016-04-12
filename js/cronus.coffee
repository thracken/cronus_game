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

class StorySegment
  constructor: (@num, @images) ->
    #unlock = ->
    @show = ->
      html = "<div id='story-segment-1' class='container-fluid modal fade'>"+"
        <div class='modal-dialog modal-lg' role='document'>"+"
          <div class='modal-content'>"+"
            <div class='modal-header'>"+"
              <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"+"
              <h4 class='modal-title' id='myModalLabel'>" + @num + "</h4>"+"
            </div>"+"
            <div class='modal-body'>"+"
              <img class='story-image' src=" + @images[0] + " class='row' />"+"
              <p class='row'>This is the body text. Yay!</p>"+"
            </div>"+"
            <div class='modal-footer'>"+"
            </div>"+"
          </div>"+"
        </div>"+"
      </div>"
      $('body').append(html)
      $('#story-segment-1').modal "show"

segment1 = new StorySegment(1, ["img/tube1.jpg","img/tubes.png"])




first_launch = ->
  true

first_run = ->
  if first_launch
    segment1.show()




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
###
