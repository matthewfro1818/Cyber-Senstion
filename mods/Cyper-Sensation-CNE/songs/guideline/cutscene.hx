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
		Basically! After BF jump into portal he appear in white void space and he have no idea where the exit LOL
		But then something light up from his pocket!
		It’s a device that look like a watch!
		And then someone show up!
		It’s Tiny! The AI That Talia Created!
		Tiny look into situation and tell BF to use this device to travel thought universe or world! To go back to his home
		But BF don’t know how. So Tiny Explain it in nerd way
		Then BF just yell! And show her a microphone then Tiny turn into Human Form Then We stared!
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