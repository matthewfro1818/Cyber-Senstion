if(PlayState.SONG.meta.displayName == 'credits') return;
var songinfo:FlxSprite; 
var praticle:FlxSprite; 
public var songtite:FunkinText;
public var musciain:FunkinText;
var songbackground:FlxSprite;
function create()
{
trace('playstate');

}

function postCreate()
{

    songbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
	songbackground.alpha = 0;
	songbackground.updateHitbox();
	songbackground.cameras = [camHUD];
    songbackground.screenCenter(FlxAxes.X);
	songbackground.scrollFactor.set();

    songinfo = new FlxSprite();
    songinfo.frames = Paths.getSparrowAtlas('game/song_info2');
    songinfo.animation.addByPrefix('idle', 'song info', 24, false);
    songinfo.antialiasing = true;

    songinfo.updateHitbox();
    songinfo.x = -400;
    songinfo.y = 100;

    praticle = new FlxSprite();
    praticle.frames = Paths.getSparrowAtlas('game/praticle');
    praticle.animation.addByPrefix('idle', 'praticle', 24, false);
    praticle.antialiasing = true;
    praticle.alpha = 0;

    praticle.updateHitbox();

    praticle.cameras = [camHUD];

    songinfo.cameras = [camHUD];
    //75 217 柔らかい
    songtite = new FunkinText(-2200, 217, 0, PlayState.SONG.meta.displayName, 74, true);
    if(PlayState.SONG.meta.displayName == 'Yawarakai')
        {
            songtite.text = '柔らかい';
            songtite.y -= 40;
            songtite.font = Paths.font("JP.ttf");
        }
    songtite.cameras = [camHUD];

    musciain = new FunkinText(-2200, 287, 0, "By "  + PlayState.SONG.meta.composer, 30, true);
    musciain.cameras = [camHUD];

    musciain.alignment =  "right";
    songtite.alignment = "left";

    praticle.x = Math.min(550 , 670 + songtite.width - musciain.width);
    praticle.y = 180;
    
    add(songbackground);
    add(songinfo);
    add(praticle);
    add(songtite);
    add(musciain);
}

function onCountdown(event:CountdownEvent) {
    if (event.swagCounter == 3)
        {
            FlxTween.tween(songbackground, {alpha: 0.6}, 0.5);
            FlxTween.tween(songtite, {x: 75}, 0.8, {ease: FlxEase.quadInOut, startDelay: 0.25, onComplete: function(tween:FlxTween)
            {
                FlxTween.tween(songtite, {x: 419}, 3, {ease: FlxEase.quadInOut, startDelay: 0.1});
                praticle.animation.play('idle');
                FlxTween.tween(praticle, {alpha: 1}, 0.1, {ease: FlxEase.quadInOut});

                  
            }});
            FlxTween.tween(musciain, {x: Math.min(375, 75 + songtite.width - musciain.width)}, 0.8, {ease: FlxEase.quadInOut, startDelay: 0.3, onComplete: function(tween:FlxTween)
                {
                    FlxTween.tween(musciain, {x: Math.min(575, 419 + songtite.width - musciain.width)}, 3, {ease: FlxEase.quadInOut, startDelay: 0.1});
                
                }});
            new FlxTimer().start(2.3, function(tmr:FlxTimer)
                {
                    FlxTween.cancelTweensOf(songtite);
                    FlxTween.cancelTweensOf(musciain); 

                    FlxTween.tween(songtite, {x: 2200}, 0.8, {ease: FlxEase.quadInOut});
                    FlxTween.tween(musciain, {x: 2200}, 0.8, {ease: FlxEase.quadInOut});
                    trace('SONG INFO DONE');
                    FlxTween.tween(songbackground, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut});
               
                });
        
        }
 
}


function onStartSong()
{
    songinfo.animation.play('idle');
    
						
}

/*function update()
    {
        if (FlxG.keys.justPressed.O)
            {
                trace(praticle);
            }
        if (FlxG.keys.justPressed.LEFT)
            {
                praticle.x -=10;
            }
        if (FlxG.keys.justPressed.RIGHT)
            {
                praticle.x +=10;
            }
        if (FlxG.keys.justPressed.UP)
            {
                praticle.y -=10;
            }
        if (FlxG.keys.justPressed.DOWN)
            {
                praticle.y +=10;
            }    
    }*/