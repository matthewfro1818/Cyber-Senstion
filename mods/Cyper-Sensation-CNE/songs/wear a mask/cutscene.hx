if (!PlayState.isStoryMode && PlayState.difficulty.toLowerCase() != "regular") return;
import haxe.Json;
import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.assets.ModsFolder;
import Sys;

public var cutva:FlxSound;
var dublang:String = '-en';
var sublang:String = '-en';
var videoname:String = 'ch1-2';
public var skippable:Bool = true;
public var cutended:Bool = false;
var usesub:Bool = false;

var bgsub:FlxSprite;
var subtitle:FunkinText;
var jsonString = '';
public var subtitles = [];
var videoCamera:FlxCamera;
var cutsceneCamera:FlxCamera;

function playvideo(videoname) {
	trace('playvide');
	if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/CH1/' + videoname + '.mp4'))
		new FlxTimer().start(0.001, function(tmr:FlxTimer) {
			video.play();
			cutended=false;
			skippable=true;
			cutva.play();
		});
}

function videokill()
	{
		video.destroy();
		if (!FlxG.save.data.BotPlay) { addVirtualPad('NONE', 'NONE'); }
		PlayState.instance.inCutscene = false;
		PlayState.instance.startCountdown();
		cutva.stop();
		cutended = true;
		if(usesub) {remove(bgsub); remove(subtitle);}
	}

function create() {
	trace("Use Sub: "+FlxG.save.data.useSubs+ sublang + " Use Dub: "+ dublang);
  if(FlxG.save.data.useSubs) {usesub = true;}
	if(FlxG.save.data.thaiDub) {dublang = '-th';}
  if(FlxG.save.data.thaiSub) {sublang = '-th';}
  jsonString = Paths.file('videos/CH1/' + videoname + sublang + '.json');
	PlayState.instance.inCutscene = true;

	videoCamera = new FlxCamera();
	videoCamera.bgColor = 0;
	FlxG.cameras.add(videoCamera, false);
	
	addVirtualPad('NONE', 'A');
	addVirtualPadCamera();

	video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
	video.bitmap.onEndReached.add(videokill);
	video.cameras = [videoCamera];

	add(video);

	playvideo(videoname);
	//TO DO: Make options to select dub
	cutva = FlxG.sound.load(Paths.sound('cutscene/ch1/' + videoname + dublang), 1);


	bgsub = new FlxSprite(0, FlxG.height * 0.85).makeGraphic(1, 1, 0xFF000000);
	bgsub.alpha = 0.5;
	bgsub.visible = false;

  if(usesub)
  {
    subtitle = new FunkinText(0, FlxG.height * 0.875, 0, "", 32);
    subtitle.alignment = 'CENTER';
    if(FlxG.save.data.thaiSub) {subtitle.font = Paths.font('thai-font.ttf');}
    subtitle.screenCenter(FlxAxes.X);
    subtitle.visible = false;
  
    bgsub.scale.set(subtitle.width + 8, subtitle.height + 8);
    bgsub.updateHitbox();
    bgsub.setPosition(subtitle.x - 4, subtitle.y - 4);
  
    subtitle.cameras = [videoCamera];
    bgsub.cameras = [videoCamera];
  
    add(bgsub);
    add(subtitle);
  
    trace(jsonString);
  
    parseSubtitle(jsonString);
  
    for (_subtitle in subtitles) {
      trace("Time: " + _subtitle.time);
      trace("Text: " + _subtitle.text);
    }
  }

}

function update(elapsed) {
	if(!cutended) {
		video.screenCenter(FlxAxes.XY);
		video.setGraphicSize(FlxG.width, FlxG.height);

		if (skippable && video.bitmap.isPlaying && controls.ACCEPT) 
		{
			video.destroy();
			if (!FlxG.save.data.BotPlay) { addVirtualPad('NONE', 'NONE'); }
			PlayState.instance.inCutscene = false;
			PlayState.instance.startCountdown();
			cutva.stop();
			cutended = true;
			if(usesub) {remove(bgsub); remove(subtitle);}
		}

		@:privateAccess
		var time = video.bitmap.time;
		// trace(time);

		if(subtitles != null && usesub)
			while (subtitles.length > 0 && subtitles[0].time < time)
				setSubtitle(subtitles.shift());
	}

	
}

public function setSubtitle(sub:Array) {
	if (bgsub.visible = subtitle.visible = (sub.text.length > 0)) {
		subtitle.text = sub.text;
		subtitle.screenCenter(FlxAxes.X);
		bgsub.scale.set(subtitle.width + 8, subtitle.height + 8);
		bgsub.updateHitbox();
		bgsub.setPosition(subtitle.x - 4, subtitle.y - 4);
	}
}

public function splitTime(str:String):Float {
	if (str == null || str == "" || StringTools.trim(str) == "") return -1;
	var multipliers:Array<Float> = [1, 60, 3600, 86400]; // no way a cutscene will last longer than days
	var timeSplit:Array<Null<Float>> = [];
	for(e in str.split(":"))
		timeSplit.push(Std.parseFloat(e));
	var time:Float = 0;

	for(k in 0...timeSplit.length)
	{
		var i = timeSplit[k];
		var mul = multipliers[timeSplit.length - 1 - k];
		if (i != null)
			time += i * mul;
		trace(time*1000);
	}

	return time;
}

public function parseSubtitle(jsonString):Array
{
	trace(jsonString);
	var jsonData = CoolUtil.parseJson(jsonString);

	if (jsonData != null && jsonData.subtitles != null) {
		var subtitleData:Array<Dynamic> = jsonData.subtitles;
		for (_subtitle in subtitleData) {
			//var subtitleObj:Subtitle = new Subtitle();


			var timeStr:String = _subtitle.time;
			var timeInSeconds:Float = splitTime(timeStr);
			//subtitleObj.time = timeInSeconds * 1000; // Convert to milliseconds
			//subtitleObj.text = subtitle.text;
			subtitles.push({
				time: timeInSeconds * 1000,
				text: _subtitle.text
			});
			trace(_subtitle);
		}
	}

	trace(subtitles);
}

/*
class Subtitle {
	public function new() {
	}
	public var time:Float;
	public var text:String;
}*/