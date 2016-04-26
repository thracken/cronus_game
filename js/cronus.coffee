#Currencies
class Currency
  constructor: (@name, @amount) ->
    @spend = (amount) ->
      @amount -= amount
    @gain = ->
      @amount += amount

gold = new Currency("Gold", 0)
xp = new Currency("Experience", 0)
crystals = new Currency("Crystals", 0)



#Player Stat Items
class TeamMember
  constructor: (@name,main_stat) ->
    @str = 1
    @fort = 1
    @dex = 1
    @speed = 1
    @energy = 20

    @skill_points = 0
    @total_xp_gained = 0

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
    @lvl = ->
      1


#Story Items
class StorySegment
  @SegmentsCompleted = 0
  constructor: (@num, @name, @images) ->
    #unlocked = ->
    @progression = 0

    @completed = ->
      if @progression >= @images.length - 1
        true
      else
        false

    @show = ->
      html = "<div id='story-segment-1' class='container-fluid modal fade'>"+"
        <div class='modal-dialog modal-lg' role='document'>"+"
          <div class='modal-content'>"+"
            <div class='modal-header'>"+"
              <button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"+"
              <h4 class='modal-title' id='myModalLabel'>" + @num + " - " + @name + "</h4>"+"
            </div>"+"
            <div class='modal-body'>"+"
              <img class='story-image' src=" + @images[@progression] + " class='row' />"+"
            </div>"+"
            <div class='modal-footer'>"+"
            </div>"+"
          </div>"+"
        </div>"+"
      </div>"
      $('body').append(html)
      $('#story-segment-1').modal({"show": "true", backdrop: "static"})
      #Advance to next image when clicked
      $('.story-image').click( =>
          @progression += 1
          $('.story-image').attr('src', @images[@progression])
      )




segment1 = new StorySegment(1, "Let's get out of here...", ["img/tube1.jpg","img/tube2.jpg","img/tube3.jpg","img/tube4.jpg","img/tube5.jpg","img/tube6.jpg","img/tube7.jpg","img/tube8.jpg","img/tube9.jpg"])


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
