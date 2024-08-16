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
public var skippable:Bool = false;
public var cutended:Bool = false;

var videoCamera:FlxCamera;
var cutsceneCamera:FlxCamera;


function create() {
	if(!cutended)
	{
		PlayState.instance.inCutscene = true;

	
		cutCamera = new FlxCamera();
		cutCamera.bgColor = 0;
		FlxG.cameras.add(cutCamera, false);
	
		bgsub = new FlxSprite(0,0).makeGraphic(FlxG.width * 2.85, FlxG.height * 2.85, 0xFF000000);
		bgsub.cameras = [cutCamera];
		bgsub.visible = true;
		add(bgsub);
	
		longshort = new FunkinText(525, 547, 0, "BOTPLAY", 37/2, true);
		longshort.visible = true;
		longshort.alignment = 'center';
		longshort.cameras = [cutCamera];
	
		add(longshort);
	
		longshort.text = "(Long Story Short Time!!)
		Basically! Talia dying but luckily that Tiny helped BF out in time
		and now BF distract the Errorians so Tiny can Help Talia out! And then The Final Battle begins!
		
		
		
		
		
		\n\n[Press Enter To Continue]
		";
	
		longshort.screenCenter(FlxAxes.XY);
	
		new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				skippable = true;
			});
	}
	else
	{
		PlayState.instance.inCutscene = false;
		PlayState.instance.startCountdown();
	}
	


}

function update(elapsed) {
	if(!cutended) {
		if (skippable && FlxG.mouse.justPressed) 
		{
			PlayState.instance.inCutscene = false;
			PlayState.instance.startCountdown();
			longshort.destroy();
			bgsub.destroy();
			
			remove(cutCamera);
			remove(longshort);
			remove(bgsub);

			cutended = true;
		}

	}

	
}