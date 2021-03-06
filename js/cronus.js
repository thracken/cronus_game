// Generated by CoffeeScript 1.10.0
var Ability, Acheivement, Currency, Equipment, StoryPage, StorySegment, Team, TeamArmor, TeamEquipment, TeamMember, crystals, first_launch, first_run, gold, segment1, segment1_pages, story001_0, story001_1, story001_2, story001_3, story001_4, story001_5, story001_6, story001_7, story001_8, xp, xp_tick;

StoryPage = (function() {
  function StoryPage(image1, text, animate) {
    this.image = image1;
    this.text = text;
    this.animate = animate != null ? animate : function() {};
  }

  return StoryPage;

})();

StorySegment = (function() {
  StorySegment.total_segments = 0;

  StorySegment.segments_completed = 0;

  function StorySegment(num, name, pages) {
    this.num = num;
    this.name = name;
    this.pages = pages;
    this.completed = false;
    this.unlock = function() {
      var html, segment_link;
      segment_link = "<div><p id ='segment_link_" + this.num + "' class='segment_link'>" + this.num + " - " + this.name + "</p></div>";
      $('#story_tab').append(segment_link);
      html = "<div id='story-segment-" + this.num + "' class='story-segment modal fade'> <div class='modal-dialog' role='document'> <div class='modal-content'> <div class='modal-header'> <button id='story-close' type='button' class='close' data-dismiss='modal' aria-label='Close' title='Close'><span aria-hidden='true'>&times;</span></button> <h4 class='modal-title' id='myModalLabel'>" + this.num + " - " + this.name + "</h4> </div> <div class='modal-body'> <span id='story-arrow-left' class='glyphicon glyphicon-chevron-left'></span> <img id='segment-" + this.num + "-image' class='story-image' src='" + this.pages[0].image + "' class='row' /> <div id='segment-" + this.num + "-text' class='segment-text'>" + this.pages[0].text + "</div> <span id='story-arrow-right' class='glyphicon glyphicon-chevron-right'></span> </div> <div class='modal-footer'> </div> </div> </div> </div>";
      $('#wrapper').append(html);
      return $("#segment_link_" + this.num).click((function(_this) {
        return function() {
          return setTimeout("segment" + _this.num + ".show()", 0);
        };
      })(this));
    };
    this.show = function() {
      var progress;
      progress = 0;
      $("#story-segment-" + this.num).modal({
        "show": "true",
        backdrop: "static"
      });
      this.pages[progress].animate();
      $('#story-arrow-left').click((function(_this) {
        return function() {
          if (progress > 0) {
            progress -= 1;
            $('.story-image').attr('src', _this.pages[progress].image);
            $("#segment-" + _this.num + "-text").text(_this.pages[progress].text);
            return _this.pages[progress].animate();
          }
        };
      })(this));
      $('#story-arrow-right').click((function(_this) {
        return function() {
          if (progress === _this.pages.length - 1) {
            $('#story-close').click();
            _this.completed = true;
          }
          if (progress < _this.pages.length - 1) {
            progress += 1;
            $('.story-image').attr('src', _this.pages[progress].image);
            $("#segment-" + _this.num + "-text").text(_this.pages[progress].text);
            return _this.pages[progress].animate();
          }
        };
      })(this));
      return $('#story-close').click((function(_this) {
        return function() {
          if (progress === _this.pages.length - 1) {
            return _this.completed = true;
          }
        };
      })(this));
    };
  }

  return StorySegment;

})();

segment1_pages = [
  story001_0 = new StoryPage('img/intro0.jpg', '*Wha... what? Where am I?*', function() {
    $("#segment-1-image").css({
      bottom: "0px"
    });
    return $("#segment-1-image").animate();
  }), story001_1 = new StoryPage('img/intro1.jpg', '"Hey! Let\'s get you out of there."', function() {
    var image;
    image = $("#segment-1-image");
    return image.css("bottom", '');
  }), story001_2 = new StoryPage('img/intro2.jpg', '*Hnngh!*', function() {}), story001_3 = new StoryPage('img/intro3.jpg', 'And so on...', function() {}), story001_4 = new StoryPage('img/intro4.jpg', 'Text Here', function() {}), story001_5 = new StoryPage('img/intro5.jpg', 'And Here', function() {}), story001_6 = new StoryPage('img/intro6.jpg', 'Also Here', function() {}), story001_7 = new StoryPage('img/intro7.jpg', 'Here Too', function() {}), story001_8 = new StoryPage('img/intro8.jpg', 'More Text Here', function() {}), story001_8 = new StoryPage('img/intro9.jpg', 'Final Text Here', function() {})
];

segment1 = new StorySegment(1, "Let's get out of here...", segment1_pages);

Currency = (function() {
  function Currency() {
    this.amount = 0;
    this.spend = function(amount) {
      return this.amount -= amount;
    };
    this.gain = function(amount) {
      return this.amount += amount;
    };
  }

  return Currency;

})();

gold = new Currency;

xp = new Currency;

crystals = new Currency;

Equipment = (function() {
  function Equipment() {}

  return Equipment;

})();

Acheivement = (function() {
  function Acheivement(name, unlock_condition) {
    this.name = name;
    this.unlock_condition = unlock_condition;
  }

  return Acheivement;

})();

Team = (function() {
  function Team() {}

  return Team;

})();

TeamMember = (function() {
  function TeamMember(name, team_class) {
    var main_stat_multiplier;
    this.name = name;
    main_stat_multiplier = 1.5;
    this.total_xp_earned = 0;
    this.level = 0;
    this.active = false;
    this.skill_points = new Currency;
    this.equipment = [];
    this.armor = [];
    this.abilities = [];
    switch (team_class) {
      case "Balance":
        this.strength = 5;
        this.fortitude = 5;
        this.dexterity = 5;
        this.speed = 5;
        this.base_energy = 5;
        this.main_stat = "strength";
        break;
      case "Agility":
        this.strength = 3;
        this.fortitude = 4;
        this.dexterity = 6;
        this.speed = 7;
        this.base_energy = 5;
        this.main_stat = "speed";
        break;
      case "Tank":
        this.strength = 7;
        this.fortitude = 7;
        this.dexterity = 4;
        this.speed = 3;
        this.base_energy = 4;
        this.main_stat = "fortitude";
        break;
      case "Flying":
        this.strength = 4;
        this.fortitude = 4;
        this.dexterity = 6;
        this.speed = 6;
        this.base_energy = 5;
        this.main_stat = "dexterity";
        break;
      case "Tech":
        this.strength = 4;
        this.fortitude = 4;
        this.dexterity = 5;
        this.speed = 5;
        this.base_energy = 7;
        this.main_stat = "energy";
        break;
      case "Range":
        this.strength = 4;
        this.fortitude = 4;
        this.dexterity = 6;
        this.speed = 5;
        this.base_energy = 6;
        this.main_stat = "dexterity";
        break;
      case "Combat":
        this.strength = 6;
        this.fortitude = 6;
        this.dexterity = 5;
        this.speed = 5;
        this.base_energy = 3;
        this.main_stat = "strength";
        break;
      case "Support":
        this.strength = 4;
        this.fortitude = 6;
        this.dexterity = 4;
        this.speed = 4;
        this.base_energy = 7;
        this.main_stat = "energy";
        break;
      case "Stealth":
        this.strength = 3;
        this.fortitude = 3;
        this.dexterity = 7;
        this.speed = 6;
        this.base_energy = 6;
        this.main_stat = "dexterity";
        break;
      case "Caster":
        this.strength = 4;
        this.fortitude = 4;
        this.dexterity = 4;
        this.speed = 5;
        this.base_energy = 8;
        this.main_stat = "energy";
        break;
      case "Berserker":
        this.strength = 8;
        this.fortitude = 4;
        this.dexterity = 4;
        this.speed = 5;
        this.base_energy = 4;
        this.main_stat = "strength";
    }
    this.hp = function() {
      return this.fortitude * 10;
    };
    this.crit_chance = function() {
      return this.dexterity / 100;
    };
    this.crit_damage = function() {
      return 1 + ((this.dexterity + this.strength) / 100);
    };
    this.armor = function() {
      return this.fort * 0.5;
    };
    this.energy = function() {
      return this.base_energy * 5;
    };
    switch (this.main_stat) {
      case "strength":
        this.damage = function() {
          return this.strength * main_stat_multiplier;
        };
        break;
      case "fortitude":
        this.damage = function() {
          return this.fortitude * main_stat_multiplier;
        };
        break;
      case "dexterity":
        this.damage = function() {
          return this.dexterity * main_stat_multiplier;
        };
        break;
      case "speed":
        this.damage = function() {
          return this.speed * main_stat_multiplier;
        };
        break;
      case "energy":
        this.damage = function() {
          return this.base_energy * main_stat_multiplier;
        };
    }
  }

  return TeamMember;

})();

Ability = (function() {
  function Ability(name, energy_cost, upgrade_cost, cooldown, level_required) {
    this.name = name;
    this.energy_cost = energy_cost;
    this.upgrade_cost = upgrade_cost;
    this.cooldown = cooldown;
    this.level_required = level_required;
  }

  return Ability;

})();

TeamEquipment = (function() {
  function TeamEquipment() {}

  return TeamEquipment;

})();

TeamArmor = (function() {
  function TeamArmor() {}

  return TeamArmor;

})();

xp_tick = function() {
  xp.gain(1);
  return $('#xp_label').text(xp.amount + " xp");
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

$(document).ready(function() {
  first_run();
  return window.setInterval(function() {
    return xp_tick();
  }, 1000);
});
