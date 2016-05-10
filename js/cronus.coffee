#Story Functionality
class StoryPage
  constructor: (@image, @text) -> #add @animation

class StorySegment
  @SegmentsCompleted = 0
  constructor: (@num, @name, @pages) ->
    progress = 0
    @completed = false

    @unlock = ->
      segment_link = "<div><p><a href='#' class='segment_link' onclick='segment_links(" + @num + ")'>" + @num + " - " + @name + "</a></p></div>"
      $('#story_tab').append(segment_link)
    @show = ->

#Segment 1
#Pages
segment1_pages = [\
story001_1 = new StoryPage('img/tube1.jpg', '<em>Wha... what? Where am i?</em>')
, story001_2 = new StoryPage('img/tube2.jpg', '"Hey! Let\'s get you out of there."')
, story001_3 = new StoryPage('img/tube3.jpg', '*Hnngh!*')
, story001_4 = new StoryPage('img/tube4.jpg', 'And so on...')
, story001_5 = new StoryPage('img/tube5.jpg', '')
, story001_6 = new StoryPage('img/tube6.jpg', '')
, story001_7 = new StoryPage('img/tube7.jpg', '')
, story001_8 = new StoryPage('img/tube8.jpg', '')
, story001_9 = new StoryPage('img/tube9.jpg', '')
]

segment1 = new StorySegment(1, "Let's get out of here...", segment1_pages)



segment_links = (num) ->
  name = "segment" + num
  setTimeout("#{name}.show()",0)

###
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
                      <img class='story-image' src=" + @images[progress] + " class='row' />"+"
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
          progress -= 1
          $('.story-image').attr('src', @images[progress])
      )
      $('#story-arrow-right').click( =>
          if progress == @images.length - 1
            $('#story-close').click()
            @completed = true
          if progress < @images.length - 1
            progress += 1
            $('.story-image').attr('src', @images[progress])
      )
      $('#story-close').click( =>
        if progress == @images.length - 1
          @completed = true
      )


###

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
skill_points = new Currency("Skill Points", 0)


#TeamMemeber Functionality
class TeamMember
  constructor: (@name,main_stat) ->
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
    @lvl = ->
      0


#Menu Tabs



#General Functions
first_launch = ->
  false

first_run = ->
  if first_launch()
    segment1.unlock()
    segment1.show()

xp_tick = ->
  xp.gain(1)
  $('#xp_label').text("#{xp.amount} xp")


#Game Loop
$(document).ready ->
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
