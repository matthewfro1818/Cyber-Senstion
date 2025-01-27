import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import funkin.backend.assets.ModsFolder;
import flixel.util.FlxSave;

var videoCamera:FlxCamera;
var cutsceneCamera:FlxCamera;
var video:FlxVideoSprite;
var t:FlxTween;
var t2:FlxTween;
function create() {
    

    videoCamera = new FlxCamera();
    videoCamera.bgColor = 0;
    FlxG.cameras.add(videoCamera, false);

    video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
    video.cameras = [videoCamera];

    add(video);




}

function postCreate() {

    cameraMovementEnabled = true;

    bell = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/nomore/bell'));
	bell.scrollFactor.set(0, 0);
	bell.alpha = 0;
    bell.screenCenter(FlxAxes.XY);
    bell.cameras = [camHUD];
	add(bell);

    scream = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/nomore/tom'));
	scream.scrollFactor.set(0, 0);
	scream.alpha = 0;
    scream.screenCenter(FlxAxes.XY);
    scream.cameras = [camHUD];
	add(scream);

    neko = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/nomore/neko'));
	neko.scrollFactor.set(0, 0);
	neko.alpha = 0;
    neko.scale.set(0.3,0.3);
    neko.screenCenter(FlxAxes.XY);
    neko.cameras = [camHUD];
	add(neko);

    var index = members.indexOf(dad);

    //player middle scroll
    strumLines.members[1].members[0].setPosition(420,50);
    strumLines.members[1].members[1].setPosition(530,50);
    strumLines.members[1].members[2].setPosition(640,50);
    strumLines.members[1].members[3].setPosition(750,50);
    
    if (FlxG.save.data.MiddleScroll) {
    //player 2
    strumLines.members[3].members[0].setPosition(420,50);
    strumLines.members[3].members[1].setPosition(530,50);
    strumLines.members[3].members[2].setPosition(640,50);
    strumLines.members[3].members[3].setPosition(750,50);
    
    //opponent psych middle scroll
    strumLines.members[2].members[2].setPosition(930,50);
    strumLines.members[2].members[3].setPosition(1040,50);
    
    for(s in strumLines.members[2].members) 
            {
                    s.alpha = 0.7;
            }
    // end
    }

    strumLines.members[2].characters[0].setPosition(100,200);
    strumLines.members[3].characters[0].setPosition(1100,100);
    /*
    strumLines.members[0].members[0].setPosition(100,0);
    strumLines.members[0].members[1].setPosition(215,0);
    strumLines.members[0].members[2].setPosition(330,0);
    strumLines.members[0].members[3].setPosition(445,0);
    */

    strumLines.members[3].characters[0].visible = false;
    strumLines.members[2].characters[0].visible = false;


    outside = new FlxSprite(-600, 40).loadGraphic(Paths.image('stages/nonsense/Outside'));
	outside.scrollFactor.set(0.8, 0.8);


    inside = new FlxSprite(-800, -370).loadGraphic(Paths.image('stages/nonsense/BACKGROUND'));
	inside.scrollFactor.set(0.9, 0.9);

    inside.alpha = outside.alpha = 0;

    insert(index, inside);
    insert(index, outside);

    monochrome = new CustomShader("monochrome");

    for(s in strumLines.members[2].members) 
		{
			s.visible = false;
		}

    for(s in strumLines.members[3].members) 
		{
			s.visible = false;
		}
    
    
} 

function screaming(who:String)
{
    remove(scream);
    scream.loadGraphic(Paths.image('stages/nomore/' + who));
    trace(scream);
    scream.scrollFactor.set(0, 0);
    scream.setGraphicSize(FlxG.width, FlxG.height);
    scream.cameras = [camHUD];
    scream.screenCenter(FlxAxes.XY);
    add(scream);
    if(t2 != null)
    {
        t2.cancel();
    }
    scream.alpha = 1;
    t2 = FlxTween.tween(scream, {alpha: 0}, 0.5,{ease: FlxEase.quadInOut});
}

function ring()
{
        if(t != null)
        {
            t.cancel();
        }
        bell.alpha = 1;
        t = FlxTween.tween(bell, {alpha: 0}, 0.5,{ease: FlxEase.quadInOut});
}


function videokill()
{
        video.destroy();
}

function videomidsong(videoname) 
{
    trace('playvide');
    if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
        new FlxTimer().start(0.001, function(tmr:FlxTimer) {
            video.play();
        });
}

function onStartSong()
    {
        ring();
                            
    }

function postUpdate(elapsed:Float) { 
    video.screenCenter(FlxAxes.XY);
    video.setGraphicSize(FlxG.width, FlxG.height);

    if(FlxG.keys.justPressed.B || virtualPad.buttonA.justPressed)
        {
            strumLines.members[3].cpu = !strumLines.members[3].cpu;
        }
} 



function beatHit()
{
    if(curBeat >= 1 && curBeat < 29 && curBeat % 8 == 0)
        {
            ring();
        }
}


function onNoteHit(_) {
    _.showRating = false;
}

function stepHit()
{
    switch(curStep)
    {
        case 119:
            videomidsong('nondead1');
            FlxTween.tween(video, {alpha: 1}, 0.3, {ease: FlxEase.circIn});
        case 128:
            FlxTween.tween(video, {alpha: 0}, 0.4, {ease: FlxEase.circIn});
        case 504:
            screaming('tom');



        case 375:
            video.alpha = 1;
        case 383:
            video.alpha = 0;
        case 640:
            for(s in strumLines.members[3].members) 
            {
                    s.visible = true;
            }
            
            for(s in strumLines.members[2].members) 
            {
                    s.visible = true;
            }

            for(s in strumLines.members[1].members) 
            {
                    s.visible = false;
            }
            
            for(s in strumLines.members[0].members) 
            {
                    s.visible = false;
            }

            camHUD.flash(0xFFFFFFFF, 0.5);
            defaultCamZoom = 0.8;
            inside.alpha = outside.alpha = 1;
            camGame.addShader(monochrome);
            camHUD.addShader(monochrome);
            camNewHUD.addShader(monochrome);
            strumLines.members[3].characters[0].visible = true;
            strumLines.members[2].characters[0].visible = true;
            dad.alpha = 0;
            playerStrums.characters = [tae];
            cpuStrums.characters = [non];


        case 896:
            for(s in strumLines.members[3].members) 
            {
                        s.visible = false;
            }
            
            for(s in strumLines.members[2].members) 
            {
                    s.visible = false;
            }

            for(s in strumLines.members[1].members) 
            {
                    s.visible = true;
            }  
            
            for(s in strumLines.members[0].members) 
            {
                    s.visible = true;
            }  
                                
            camHUD.flash(0xFFFFFFFF, 0.5);
            defaultCamZoom = 0.5;

            dad.alpha = 1;

            inside.alpha = outside.alpha = 0;
            strumLines.members[3].characters[0].visible = false;
            strumLines.members[2].characters[0].visible = false;
            camGame.removeShader(monochrome);
            camHUD.removeShader(monochrome);
            camNewHUD.removeShader(monochrome);

            for(s in strumLines.members[3].members) 
                {
                        s.visible = false;
                }

            for(s in strumLines.members[1].members) 
                {
                    s.visible = true;
                }


        case 964:
            screaming('scream');
        case 971:
            screaming('ishow');
        case 980:
            camGame.shake(0.05, 0.5, null, true);
            screaming('jump');
        case 1008:
            FlxTween.tween(neko, {alpha: 0.5}, 0.7, {ease: FlxEase.circOut});
        case 1016:
            FlxTween.tween(neko, {alpha: 0}, 1, {ease: FlxEase.circIn});

        case 1116:
            videomidsong('nondead2');
            video.alpha = 1;
        case 1120:
            FlxTween.tween(video, {alpha: 0}, 0.3, {ease: FlxEase.circIn});
        case 1128:
            FlxTween.tween(video, {alpha: 1}, 0.3, {ease: FlxEase.circIn});
        case 1151:
            FlxTween.tween(video, {alpha: 0}, 0.3, {ease: FlxEase.circIn});
        case 1208:
            video.alpha = 1;
        case 1216:
            video.alpha = 0;
        case 1264:
            FlxTween.tween(video, {alpha: 1}, 0.3, {ease: FlxEase.circIn});
        case 1280:
            video.alpha = 0;
    }
}

