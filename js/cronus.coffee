#Story Segments
class StoryPage
  constructor: (@image, @text) -> #add @animation

#Segment 1 Pages
segment1_pages = [
  story001_0 = new StoryPage('img/intro0.jpg', '<em>Wha... what? Where am I?</em>')
  story001_1 = new StoryPage('img/intro1.jpg', '"Hey! Let\'s get you out of there."')
  story001_2 = new StoryPage('img/intro2.jpg', '*Hnngh!*')
  story001_3 = new StoryPage('img/intro3.jpg', 'And so on...')
  story001_4 = new StoryPage('img/intro4.jpg', 'Text Here')
  story001_5 = new StoryPage('img/intro5.jpg', 'And Here')
  story001_6 = new StoryPage('img/intro6.jpg', 'Also Here')
  story001_7 = new StoryPage('img/intro7.jpg', 'Here Too')
  story001_8 = new StoryPage('img/intro8.jpg', 'More Text Here')
  story001_8 = new StoryPage('img/intro9.jpg', 'Final Text Here')
]

class StorySegment
  @total_segments = 0
  @segments_completed = 0

  constructor: (@num, @name, @pages) ->
    @completed = false

    @unlock = ->
      segment_link = "<div><p id ='segment_link_#{@num}' class='segment_link'>#{@num} - #{@name}</p></div>"
      $('#story_tab').append(segment_link)
      html = "<div id='story-segment-#{@num}' class='story-segment modal fade'>"+"
                    <div class='modal-dialog' role='document'>"+"
                      <div class='modal-content'>"+"
                        <div class='modal-header'>"+"
                          <button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close' title='Close'><span aria-hidden='true'>&times;</span></button>"+"
                          <h4 class='modal-title' id='myModalLabel'>#{@num} - #{@name}</h4>"+"
                        </div>"+"
                        <div class='modal-body'>"+"
                          <span id='story-arrow-left' class='glyphicon glyphicon-chevron-left'></span>"+"
                          <img id='segment-#{@num}-image' class='story-image' src='#{@pages[0].image}' class='row' />"+"
                          <div id='segment-#{@num}-text' class='segment-text'>#{@pages[0].text}</div>"+"
                          <span id='story-arrow-right' class='glyphicon glyphicon-chevron-right'></span>"+"
                        </div>"+"
                        <div class='modal-footer'>"+"
                        </div>"+"
                      </div>"+"
                    </div>"+"
                  </div>"
      $('#wrapper').append(html)
      $("#segment_link_#{@num}").click( =>
        setTimeout("segment#{@num}.show()", 0)
      )

    @show = ->
      progress = 0
      $("#story-segment-#{@num}").modal({"show": "true", backdrop: "static"})
      #Advance to previous/next image when clicked
      $('#story-arrow-left').click( =>
        if progress > 0
          progress -= 1
          $('.story-image').attr('src', @pages[progress].image)
          $("#segment-#{@num}-text").text(@pages[progress].text)
      )
      $('#story-arrow-right').click( =>
        if progress == @pages.length - 1
          $('#story-close').click()
          @completed = true
        if progress < @pages.length - 1
          progress += 1
          $('.story-image').attr('src', @pages[progress].image)
          $("#segment-#{@num}-text").text(@pages[progress].text)
      )
      $('#story-close').click( =>
        if progress == @pages.length - 1
          @completed = true
      )

segment1 = new StorySegment(1, "Let's get out of here...", segment1_pages)




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

#General Functions
first_launch = ->
  true

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
