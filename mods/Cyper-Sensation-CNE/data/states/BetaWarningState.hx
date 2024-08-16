import funkin.backend.MusicBeatState;
import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.assets.ModsFolder;
import sys.io.File;
import sys.io.Process;
import haxe.io.FPHelper;
import sys.FileSystem;
function postCreate()
{
   
    if(!FlxG.save.data.lasthope)
        {
            MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
            disclaimer.alpha = false;
            titleAlphabet.visible = false;
        
            videoCamera = new FlxCamera();
            videoCamera.bgColor = 0;
            FlxG.cameras.add(videoCamera, false);
        
            video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
            video.bitmap.onEndReached.add(videokill);
            video.cameras = [videoCamera];
        
            add(video);
            introsfx = FlxG.sound.load(Paths.sound('haxe'), 1);
            playvideo('haxeflixel');
        }
    else
        {
            bgsub = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
            add(bgsub);
            bgsub.screenCenter(FlxAxes.XY);
            MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
            FlxG.switchState(new TitleState());
        }

}

function playvideo(videoname) {
    trace('playvide');
    if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
        new FlxTimer().start(0.001, function(tmr:FlxTimer) {
            video.play();
            introsfx.play();
        });
}

function videokill()
{
    video.destroy();
    videoCamera.visible = false;
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
    FlxG.switchState(new TitleState());
}


function postUpdate(elapsed:Float) {
    if(!FlxG.save.data.lasthope)
    {
        video.screenCenter(FlxAxes.XY);
		video.setGraphicSize(FlxG.width, FlxG.height);
        if (video.bitmap.isPlaying && controls.ACCEPT) {
            videokill();
        }
    }

        
    
    
    }