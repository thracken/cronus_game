// Generated by CoffeeScript 1.10.0
var Currency, StorySegment, TeamMember, crystals, first_launch, first_run, gold, navigation, segment1, segment_links, xp;

Currency = (function() {
  function Currency(name1, amount1) {
    this.name = name1;
    this.amount = amount1;
    this.spend = function(amount) {
      return this.amount -= amount;
    };
    this.gain = function() {
      return this.amount += amount;
    };
  }

  return Currency;

})();

gold = new Currency("Gold", 0);

xp = new Currency("Experience", 0);

crystals = new Currency("Crystals", 0);

TeamMember = (function() {
  function TeamMember(name1, main_stat) {
    this.name = name1;
    this.str = 1;
    this.fort = 1;
    this.dex = 1;
    this.speed = 1;
    this.energy = 20;
    this.skill_points = 0;
    this.total_xp_gained = 0;
    this.hp = function() {
      return this.fort * 10;
    };
    this.crit_dmg = function() {
      return 1 + ((this.dex + this.str) / 100);
    };
    this.base_dmg = function() {
      return this.str * 1.5;
    };
    this.armor = function() {
      return this.fort * 0.5;
    };
    this.crit_chance = function() {
      return this.dex / 100;
    };
    this.dodge = function() {
      return 1 + ((this.speed + this.dex) / 100);
    };
    this.lvl = function() {
      return 1;
    };
  }

  return TeamMember;

})();

StorySegment = (function() {
  StorySegment.SegmentsCompleted = 0;

  function StorySegment(num1, name1, images) {
    var progression;
    this.num = num1;
    this.name = name1;
    this.images = images;
    progression = 0;
    this.completed = false;
    this.unlock = function() {
      var segment_link;
      segment_link = "<div>" + "<p><a href='#' class='segment_link' onclick='segment_links(" + this.num + ")'>" + this.num + " - " + this.name + "</a></p>" + "</div>";
      return $('#story_tab').append(segment_link);
    };
    this.show = function() {
      var html;
      html = "<div id='story-segment-1' class='container-fluid modal fade'>" + "<div class='modal-dialog modal-lg' role='document'>" + "<div class='modal-content'>" + "<div class='modal-header'>" + "<button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>" + "<h4 class='modal-title' id='myModalLabel'>" + this.num + " - " + this.name + "</h4>" + "</div>" + "<div class='modal-body'>" + "<span id='story-arrow-left' class='glyphicon glyphicon-chevron-left'></span>" + "<img class='story-image' src=" + this.images[progression] + " class='row' />" + "<span id='story-arrow-right' class='glyphicon glyphicon-chevron-right'></span>" + "</div>" + "<div class='modal-footer'>" + "</div>" + "</div>" + "</div>" + "</div>";
      $('#story_tab').append(html);
      $('#story-segment-' + this.num).modal({
        "show": "true",
        backdrop: "static"
      });
      $('#story-arrow-left').click((function(_this) {
        return function() {
          progression -= 1;
          return $('.story-image').attr('src', _this.images[progression]);
        };
      })(this));
      $('#story-arrow-right').click((function(_this) {
        return function() {
          if (progression === _this.images.length - 1) {
            $('#story-close').click();
            _this.completed = true;
          }
          if (progression < _this.images.length - 1) {
            progression += 1;
            return $('.story-image').attr('src', _this.images[progression]);
          }
        };
      })(this));
      return $('#story-close').click((function(_this) {
        return function() {
          if (progression === _this.images.length - 1) {
            return _this.completed = true;
          }
        };
      })(this));
    };
  }

  return StorySegment;

})();

segment_links = function(num) {
  var name;
  name = "segment" + num;
  return setTimeout(name + ".show()", 0);
};

segment1 = new StorySegment(1, "Let's get out of here...", ["img/tube1.jpg", "img/tube2.jpg", "img/tube3.jpg", "img/tube4.jpg", "img/tube5.jpg", "img/tube6.jpg", "img/tube7.jpg", "img/tube8.jpg", "img/tube9.jpg"]);

first_launch = function() {
  return true;
};

first_run = function() {
  if (first_launch) {
    segment1.unlock();
    return segment1.show();
  }
};

navigation = function() {
  $('#story_menu_link').click(function() {
    $('#story_tab').show();
    $('#armor_tab').hide();
    $('#team_tab').hide();
    $('#missions_tab').hide();
    return $('#acheivements_tab').hide();
  });
  $('#armor_menu_link').click(function() {
    $('#story_tab').hide();
    $('#armor_tab').show();
    $('#team_tab').hide();
    $('#missions_tab').hide();
    return $('#acheivements_tab').hide();
  });
  $('#team_menu_link').click(function() {
    $('#story_tab').hide();
    $('#armor_tab').hide();
    $('#team_tab').show();
    $('#missions_tab').hide();
    return $('#acheivements_tab').hide();
  });
  $('#missions_menu_link').click(function() {
    $('#story_tab').hide();
    $('#armor_tab').hide();
    $('#team_tab').hide();
    $('#missions_tab').show();
    return $('#acheivements_tab').hide();
  });
  return $('#acheivements_menu_link').click(function() {
    $('#story_tab').hide();
    $('#armor_tab').hide();
    $('#team_tab').hide();
    $('#missions_tab').hide();
    return $('#acheivements_tab').show();
  });
};

$(document).ready(function() {
  navigation();
  return first_run();
});


/*
  window.setInterval( ->

  , 1000)
StorySegment
TeamMember
Mission
Achievement
Currency
960x430 is standard size for main_image
960x430 = 900
 */
