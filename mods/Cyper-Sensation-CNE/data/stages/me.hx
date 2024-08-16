import funkin.system.FunkinSprite;
import haxe.io.Path;

var tansMid:FlxPoint = null;
var softMid:FlxPoint = null;
var softMid:FlxPoint = null;
var start:Bool = false;
public var shiver:FlxSprite;
function create() {

    var index = members.indexOf(strumLines.members[0].characters[0]);
	bg = new FlxSprite(-200, -200).loadGraphic(Paths.image('stages/me/stage'));
	bg.scale.set(1.7,1.5);
	bg.scrollFactor.set(1,1);

    insert(index, bg);

	var index = members.indexOf(bg);

	shadum = new Character(570, 260, "shadow taeyai");
	shadum.y -= 1000;
	insert(index, shadum);

	shiver = new FlxSprite(400, 0).loadGraphic(Paths.image("stages/me/shiver"));
    shiver.frames = Paths.getSparrowAtlas('stages/me/shiver');
	shiver.antialiasing = true;
    shiver.animation.addByPrefix('idle', "tile0", 24,false);
	shiver.visible = false;
	insert(index,shiver);

	boyfriend.setPosition(1365,200);
	dad.setPosition(-285,270); //Soft
	gf.setPosition(1535,335);
	strumLines.members[3].characters[0].setPosition(-725,355); //Minus
	strumLines.members[4].characters[0].setPosition(530,-180);
	strumLines.members[4].characters[0].visible = false;
	strumLines.members[4].characters = [shadum];

	for(s in strumLines.members[0].members) 
		{
			s.visible = false;
		}

}

function onNoteCreation(event)
{
	if (event.strumLineID == 1)
		{
			event.noteSprite = 'game/notes/taeyai';
		}
		
}

function onStrumCreation(event)
{
    if (event.player == 0 || event.player == 4)
		{
			event.cancelAnimation();
		}

	if (event.player == 1)
		{
			event.sprite = 'game/notes/taeyai';
		}


}

function postCreate() {

	tansMid = gf.getGraphicMidpoint();

	for(s in strumLines.members[4]) {
        s.cameras = [camGame];
        s.scrollFactor.set(1,1);
		s.x += 420;
		s.y -= 200;
        s.alpha = 0;
    }

	camGame.zoom = 1;
    camGame.scroll.set(800,230);
}

function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.5}, 2, {ease: FlxEase.backIn,
                onComplete: function(twn:FlxTween)
                {
                    start = true;
					camGame.zoom = 0.5;
					defaultCamZoom = 0.5;
                }});
        }
   
}

function onNoteHit(_) {
    _.showRating = false;
}

function beatHit()
{
	if(curBeat % 2 == 0)
	{
		shiver.animation.play('idle',true);
	}
}

function postUpdate(elapsed:Float)
    { 

		if(!start) camFollow.setPosition(800, 240);
		if(start)
		{
			switch(curCameraTarget)
			{
				case 0: //950
					if(defaultCamZoom >= 0.8)
						{
							camFollow.setPosition(440 - 200, 330 + 200);
						}
					else
						camFollow.setPosition(440, 330); //SOFT
				case 1:
					if(defaultCamZoom >= 0.8)
					{
						camFollow.setPosition(950 + 300, 330);
					}
					else
						camFollow.setPosition(950, 330); //Tans
				case 2:
					if(defaultCamZoom >= 0.8)
						{
							camFollow.setPosition(1100 + 200, 330 + 200);
						}
					else
						camFollow.setPosition(1100, 430); // TAEYAI
				case 3:
					if(defaultCamZoom >= 0.8)
						{
							camFollow.setPosition(420 - 300, 330 + 200);
						}
					else
						camFollow.setPosition(420, 430); //MINUS
				case 4: 
					camFollow.setPosition(800, 240); //SHADUM
			}
		}
		
    	if(FlxG.keys.justPressed.B || virtualPad.buttonA.justPressed)
        {
                strumLines.members[2].cpu = !strumLines.members[2].cpu;
        }



		//var damngod = strumLines.members[4].characters[0];
        //if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
       // if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
       // if (FlxG.keys.pressed.UP) damngod.y -= 5;
       // if (FlxG.keys.pressed.DOWN) damngod.y += 5;
       // if (FlxG.keys.pressed.SPACE) trace(damngod);


    }