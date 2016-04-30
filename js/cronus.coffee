#Currencies
class Currency
  constructor: (@name, @amount) ->
    @spend = (amount) ->
      @amount -= amount
    @gain = (amount) ->
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
    progression = 0
    @completed = false

    @unlock = ->
      segment_link = "<div>"+
                        "<p><a href='#' class='segment_link' onclick='segment_links(" + @num + ")'>" + @num + " - " + @name + "</a></p>"+
                      "</div>"
      $('#story_tab').append(segment_link)

    @show = ->
      html = "<div id='story-segment-1' class='container-fluid modal fade'>"+"
                <div class='modal-dialog modal-lg' role='document'>"+"
                  <div class='modal-content'>"+"
                    <div class='modal-header'>"+"
                      <button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"+"
                      <h4 class='modal-title' id='myModalLabel'>" + @num + " - " + @name + "</h4>"+"
                    </div>"+"
                    <div class='modal-body'>"+"
                      <span id='story-arrow-left' class='glyphicon glyphicon-chevron-left'></span>"+"
                      <img class='story-image' src=" + @images[progression] + " class='row' />"+"
                      <span id='story-arrow-right' class='glyphicon glyphicon-chevron-right'></span>"+"
                    </div>"+"
                    <div class='modal-footer'>"+"
                    </div>"+"
                  </div>"+"
                </div>"+"
              </div>"
      $('#story_tab').append(html)
      $('#story-segment-' + @num).modal({"show": "true", backdrop: "static"})
      #Advance to previous/next image when clicked
      $('#story-arrow-left').click( =>
          progression -= 1
          $('.story-image').attr('src', @images[progression])
      )
      $('#story-arrow-right').click( =>
          if progression == @images.length - 1
            $('#story-close').click()
            @completed = true
          if progression < @images.length - 1
            progression += 1
            $('.story-image').attr('src', @images[progression])
      )
      $('#story-close').click( =>
        if progression == @images.length - 1
          @completed = true
      )

segment_links = (num) ->
  name = "segment" + num
  setTimeout("#{name}.show()",0)

segment1 = new StorySegment(1, "Let's get out of here...", ["img/tube1.jpg","img/tube2.jpg","img/tube3.jpg","img/tube4.jpg","img/tube5.jpg","img/tube6.jpg","img/tube7.jpg","img/tube8.jpg","img/tube9.jpg"])


#Menu Navigation
navigation = ->
  $('#story_menu_link').click( ->
    $('#story_tab').show()
    $('#armor_tab').hide()
    $('#team_tab').hide()
    $('#missions_tab').hide()
    $('#acheivements_tab').hide()
  )
  $('#armor_menu_link').click(->
    $('#story_tab').hide()
    $('#armor_tab').show()
    $('#team_tab').hide()
    $('#missions_tab').hide()
    $('#acheivements_tab').hide()
  )
  $('#team_menu_link').click(->
    $('#story_tab').hide()
    $('#armor_tab').hide()
    $('#team_tab').show()
    $('#missions_tab').hide()
    $('#acheivements_tab').hide()
  )
  $('#missions_menu_link').click(->
    $('#story_tab').hide()
    $('#armor_tab').hide()
    $('#team_tab').hide()
    $('#missions_tab').show()
    $('#acheivements_tab').hide()
  )
  $('#acheivements_menu_link').click(->
    $('#story_tab').hide()
    $('#armor_tab').hide()
    $('#team_tab').hide()
    $('#missions_tab').hide()
    $('#acheivements_tab').show()
  )

#General Functions
first_launch = ->
  false

first_run = ->
  if first_launch
    segment1.unlock()
    segment1.show()

xp_tick = ->
  xp.gain(1)
  $('#xp_label').text("#{xp.amount} xp")


#Run on page load
$(document).ready ->
  navigation()
  first_run()
  window.setInterval( ->
    xp_tick()
  , 1000)

###
StorySegment
TeamMember
Mission
Achievement
Currency
960x430 is standard size for main_image
960x430 = 900 x
###
