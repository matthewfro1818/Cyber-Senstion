import funkin.system.FunkinSprite;
import haxe.io.Path;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;
function create() {

}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }
function onCountdown(event)
{
    event.volume = 0;
    if(event.swagCounter == 3)
        {
            for(s in strumLines.members[0]) {
                s.x -= FlxG.width;
            }
        }
}

function onStartSong()
{
	FlxTween.tween(logo, {alpha: 1}, Conductor.crochet / 1000 * 20, {ease: FlxEase.cubeIn});
	FlxTween.tween(titleCre, {alpha: 1}, Conductor.crochet / 1000 * 20, {ease: FlxEase.cubeIn, startDelay: 3});
	addVirtualPad('NONE', 'B');
	addVirtualPadCamera();
	removeMobileControls();
}
var start:Bool = false;
var speed:Int = 10;

function onSongEnd()
{
    FlxG.switchState(new MainMenuState());
}

function update(elapsed)
{
	if(FlxG.keys.pressed.SPACE)
		{
			speed = 10;
		}
	else {speed = 5;}
	
	if (virtualPad.buttonB.justPressed) {
        CoolUtil.playMenuSong();
        FlxG.switchState(new MainMenuState());
    }

	if(start)
	{
		if(camCredits.scroll.y < 12377.5295000001) 
			camCredits.scroll.y += 14 * elapsed * speed;
	}

	if(camCredits.scroll.y >= 12377)
	{
		if(camCredits.alpha > 0 && credreal.alpha > 0)
		{
			camCredits.alpha -= 0.01;
		}

		inst.fadeOut(2,0);

	}

	if(FlxG.keys.pressed.M)
	{
		trace(camCredits.scroll.y);
	}

	if(camCredits.alpha == 0)
	{
		CoolUtil.playMenuSong();
		FlxG.switchState(new MainMenuState());
	}


}

function beatHit()
{
	if(curBeat == 31)
	{
		start = true;
	}
}

function postCreate()
{
	dad.visible = camGame.visible = camHUD.visible = false;

	camCredits = new FlxCamera();
    camCredits.bgColor = 0;
    FlxG.cameras.add(camCredits, false);

	eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
	eventbackground2.alpha = 1;
	eventbackground2.updateHitbox();
	eventbackground2.scale.set(10,10);
	eventbackground2.cameras = [camCredits];
	eventbackground2.screenCenter(FlxAxes.XY);
	eventbackground2.scrollFactor.set(1,1);
	add(eventbackground2);

	logo=new FlxSprite();
	if(FlxG.save.data.thaiSub) {logo.loadGraphic(Paths.image('menus/titlescreen/logo-th'));}
	else{logo.loadGraphic(Paths.image('menus/titlescreen/logo'));}
	logo.screenCenter();
	logo.cameras=[camCredits];
	logo.alpha=0;
	add(logo);

	titleCre = new FunkinText(-2200, 217, 0, 'Credits', 74, true);
	titleCre.screenCenter();
	titleCre.y = logo.y + 470;
	titleCre.alpha=0;
	titleCre.cameras=[camCredits];
	add(titleCre);

	credreal = new FunkinText(0, 0, 0, 'Credits', 42, true);
	credreal.alignment = "center";


	credreal.cameras=[camCredits];
	credreal.screenCenter(FlxAxes.XY);
	credreal.x -= 430;
	credreal.y = titleCre.y + 300;
	add(credreal);

	credreal.text = '
	Directed by
	TaeYai\n
	\nWritten by\nTaeYai, TOFU\n	
	\n[Mobile Port]
	AloneGamer[KralOyuncu], DarkVerseKing
	
	\n[CNE Mobile Port]
	Mcagabe19[Lily], KarimAkra
	
	\n[Editor]
	TaeYai, Natah_DN\n
	\n[Art Director]
	JzBoy, TOFU, Jeng\n
	
	[Voice Actor]\n
	Pim.Palasite [Talia, Shadow Talia (aka. Alpha)]\n
	TOFU [Tiny, Girlfriend]\n
	TaeYai [Conner]\n
	NonsenseHumor [Nonsense]\n
	Cougar MacDowall [CJ]\n
	Jelzyart [Ruby]\n
	CJArtz [Bob]\n
	Gabriel ML [Ron]\n
	Mag Majesty [Little Man, Dust Sans]\n
	Mason [UniqueGeese]\n
	StickyBM [Sticky]\n
	CesarFever [Fever]\n
	Arcy [Shini]\n
	Sora [Aliz]\n
	And MAMON [Tans, Emiko]\n
	\n
	[Musician]\n
	P.GOD\n
	Atomixx\n
	Crystal\n
	MAMON\n
	SuperStamps\n
	TaeYai\n
	Natah_DN\n
	Mike Geno\n
	Gabriel ML\n
	SovaNova\n
	BruhSalino
	Halv\n
	WINN\n
	\n
	[Artist]\n
	JzBoy\n
	NonsenseHumor\n
	TOFU\n
	FahArtist
	A-Maze\n
	MikeFNF\n
	Spyrodile\n
	SAFDAF\n
	P.GOD\n
	LavenderFlamess
	paigeypaper\n
	SovaNova\n
	Badre\n
	Ascenti\n
	Wachi\n
	MAMON\n
	CJArtz
	Fluke_Thai\n
	\n
	[Programmer]\n
	TaeYai\n
	Yoshman29\n
	Anonymous\n
	\n
	[Charter]\n
	Kal\n
	MagMAJESTY\n
	niffirg\n
	Ryoku\n
	srife5\n
	Cerbera\n
	PhyPsi\n
	\n
	[Mod & Assets]\n
	[Vs Nonsense]\n
	NonsenseHumor\n
	\n
	[Bob]\n
	Wildythomas\n
	Phloxio\n
	\n
	[Dusttale]\n
	WassabiSoja (Director)\n
	Chuf (Dust Sans Sprite)\n
	\n
	[Doki Doki Takeover]\n
	DusterBuster (Director/Monika Assets)\n
	Team TBD\n
	\n
	[Vs UniqueGeese]\n
	Mason (Director/Background Assets)\n
	\n
	[Friday Night Fever]\n
	CesarFever (Director)\n
	Kip (Fever Sprite)\n
	\n
	[Vs Hex]\n
	YingYang (Director/Hex Assets)\n

	\n
	Thanks You For Playing My Mobile Port!
	';
}