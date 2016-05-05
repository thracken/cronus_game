// Generated by CoffeeScript 1.10.0
var Currency, Player, StorySegment, TeamMember, crystals, first_launch, first_run, gold, navigation, p, segment1, segment_links, skill_points, tick;

Currency = (function() {
  function Currency(name1, amount1, symbol, html_id) {
    this.name = name1;
    this.amount = amount1;
    this.symbol = symbol;
    this.html_id = html_id;
    this.spend = function(amount) {
      return this.amount -= amount;
    };
    this.gain = function(amount) {
      return this.amount += amount;
    };
    this.unlock = function() {
      return $('#currency_items').append("<li><a href='#' id='" + this.html_id + "' title='" + this.name + "'>" + this.amount + " " + this.symbol + "</a></li>");
    };
  }

  return Currency;

})();

gold = new Currency("Gold", 0, "g", "gold_label");

crystals = new Currency("Crystals", 0, "&loz;", "crystals_label");

skill_points = new Currency("Skill Points", 0, "<span class='glyphicon glyphicon-star-empty'></span>", "skill_point_label");

Player = (function() {
  function Player() {
    this.level = function() {
      return Math.floor(Math.log(this.xp) / Math.log(1.21));
    };
    this.xp = 0;
    this.xp_gain = function(amount) {
      return this.xp += amount;
    };
  }

  return Player;

})();

p = new Player;

TeamMember = (function() {
  function TeamMember(name1, main_stat) {
    this.name = name1;
    this.str = 1;
    this.fort = 1;
    this.dex = 1;
    this.speed = 1;
    this.energy = 20;
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
      return 0;
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

first_launch = function() {
  return true;
};

first_run = function() {
  if (first_launch()) {
    segment1.unlock();
    return segment1.show();
  }
};

tick = function() {
  p.xp_gain(1);
  $('#xp_label').text(p.xp + " xp");
  if (p.xp % 20 === 0) {
    skill_points.gain(1);
    $('');
    if (skill_points.amount === 1) {
      return skill_points.unlock();
    }
  }
};

$(document).ready(function() {
  navigation();
  first_run();
  return window.setInterval(function() {
    return tick();
  }, 1000);
});


/*
StorySegment
TeamMember
Mission
Achievement
Currency
960x430 is standard size for main_image
960x430 = 900 x
 */
