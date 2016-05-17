#Story Segments
class StoryPage
  constructor: (@image, @text) -> #add @animation

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

#Story Segment Creation
#Segment 1
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

segment1 = new StorySegment(1, "Let's get out of here...", segment1_pages)





#Currencies
class Currency
  constructor: ->
    @amount = 0
    @spend = (amount) ->
      @amount -= amount
    @gain = (amount) ->
      @amount += amount

gold = new Currency("Gold", 0)
xp = new Currency("Experience", 0)
crystals = new Currency("Crystals", 0)

#Team
class Team
  constructor: ->


#TeamMemeber Functionality
class TeamMember
  constructor: (@name,team_class) ->
    main_stat_multiplier = 1.5
    @total_xp_earned = 0
    @level = 0
    @active = false
    @skill_points = new Currency("Skill Points", 0)
    switch team_class
      when "Balance"
        @strength = 5
        @fortitude = 5
        @dexterity = 5
        @speed = 5
        @energy = 5
        @main_stat = "strength"
      when "Agility"
        @strength = 3
        @fortitude = 4
        @dexterity = 6
        @speed = 7
        @energy = 5
        @main_stat = "speed"
      when "Tank"
        @strength = 7
        @fortitude = 7
        @dexterity = 4
        @speed = 3
        @energy = 4
        @main_stat = "fortitude"
      when "Flying"
        @strength = 4
        @fortitude = 4
        @dexterity = 6
        @speed = 6
        @energy = 5
        @main_stat = "dexterity"
      when "Tech"
        @strength = 4
        @fortitude = 4
        @dexterity = 5
        @speed = 5
        @energy = 7
        @main_stat = "energy"
      when "Range"
        @strength = 4
        @fortitude = 4
        @dexterity = 6
        @speed = 5
        @energy = 6
        @main_stat = "dexterity"
      when "Combat"
        @strength = 6
        @fortitude = 6
        @dexterity = 5
        @speed = 5
        @energy = 3
        @main_stat = "strength"
      when "Support"
        @strength = 4
        @fortitude = 6
        @dexterity = 4
        @speed = 4
        @energy = 7
        @main_stat = "energy"
      when "Stealth"
        @strength = 3
        @fortitude = 3
        @dexterity = 7
        @speed = 6
        @energy = 6
        @main_stat = "dexterity"
      when "Caster"
        @strength = 4
        @fortitude = 4
        @dexterity = 4
        @speed = 5
        @energy = 8
        @main_stat = "energy"
      when "Berserker"
        @strength = 8
        @fortitude = 4
        @dexterity = 4
        @speed = 5
        @energy = 4
        @main_stat = "strength"
    @hp = ->
      @fortitude * 10
    @crit_chance = ->
      @dexterity/100
    @crit_damage = ->
      1 + ((@dexterity + @strength)/100)
    @armor = ->
      @fort * 0.5
    @dodge = ->
      (@speed + @dexterity)/100
    switch @main_stat
      when "strength"
        @damage = ->
          @strength * main_stat_multiplier
      when "fortitude"
        @damage = ->
          @fortitude * main_stat_multiplier
      when "dexterity"
        @damage = ->
          @dexterity * main_stat_multiplier
      when "speed"
        @damage = ->
          @speed * main_stat_multiplier
      when "energy"
        @damage = ->
          @energy * main_stat_multiplier



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
