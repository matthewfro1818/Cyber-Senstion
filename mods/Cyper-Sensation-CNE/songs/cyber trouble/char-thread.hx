import funkin.game.HealthIcon;
import flixel.FlxObject;
var loadedChars:Array<String> = [];
var characters:Array<Character> = [];
var gfs:Array<Character> = [];
var dads:Array<Character> = [];
var boyfriends:Array<Character> = [];
var thirdchars:Array<Character> = [];
function preloadCharacter(char:String, x:Float, y:Float, player:Bool) {
    var charac = new Character(x, y, char, player);
    characters.push(charac);
    loadedChars.push(char);
}

function isCharLoaded(char:String) {
    return loadedChars.contains(char);
}

function getCharByName(char:String) {
    return characters[loadedChars.indexOf(char)];
}

var stageLoaded:Bool = true;
function loadStage(stagename:String) {
    stageLoaded = false;
    for (i in [gf, dad, boyfriend]) remove(i);
    add(stage = new Stage(stagename));
    for (i in [gf, dad, boyfriend]) add(i);
    stageLoaded = true;
}