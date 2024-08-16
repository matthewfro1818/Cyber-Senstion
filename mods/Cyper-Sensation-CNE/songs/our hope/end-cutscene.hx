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
import funkin.backend.MusicBeatState;
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
		Basically! Shadow Talia is an old Talia’s AI that has been deleted thought her mistake while dealing with Virus Raid on Her PC.
		Her Real name is Alpha. However after the apologize and conversation. Alpha sent all the Errorains back. 
		And Talia changed Alpha into New Form. 
		While everyone is talking there a portal pops up and It’s GF! YES THE REAL ONE! BF and GF hugged and were really happy! 
		And then they waving and say goodbye to everyone. After that Talia, Alpha, Tiny go back home and that the story ends!
		(There like a Bonus song and EX Remix on Freeplay! Check it out!)
		
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
		PlayState.instance.nextSong();
	}
	


}

function update(elapsed) {
	if(!cutended) {
		if (skippable && controls.ACCEPT) 
		{
			PlayState.storyWeek = 'credits';
            PlayState.storyPlaylist = ['credits'];
                
            trace(PlayState.storyPlaylist);
            PlayState.isStoryMode = true;
            PlayState.chartingMode = false;
            MusicBeatState.nextFrameSkip = true;
            PlayState.__loadSong(PlayState.storyPlaylist[0], 'credits');
            new FlxTimer().start(1, function(tmr:FlxTimer)
            {
                FlxG.switchState(new PlayState());
            });

			cutended = true;
		}

	}

	
}