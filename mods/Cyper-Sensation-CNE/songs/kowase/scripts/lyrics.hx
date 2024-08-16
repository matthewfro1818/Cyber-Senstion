var lyrics:FunkinText;
var background:FlxSprite;
var tweens:Array<FlxTween> = [];

function postCreate()
{
	lyrics = new FunkinText(525, 547, 0, "YOUR MOM", 24, true);
    lyrics.alpha = 0;
	lyrics.cameras = [camHUD];

	background = new FlxSprite((FlxG.width / 2) - 1, lyrics.y - 5).makeGraphic(2, Std.int(lyrics.height + 10), 0xFF000000);
	background.alpha = 0;
	background.updateHitbox();
	background.cameras = [camHUD];
	background.scrollFactor.set();

	add(background);
	add(lyrics);
}

function popinLyrics() {
    for(t in tweens)
        t.cancel();

    lyrics.y = 527;
    background.y = 522;
    lyrics.alpha = background.alpha = 0;

    tweens.push(FlxTween.tween(lyrics, {y: 547, alpha: 1}, Conductor.stepCrochet / 500, {ease: FlxEase.cubeOut}));
    tweens.push(FlxTween.tween(background, {y: 542, alpha: 0.6}, Conductor.stepCrochet / 500, {ease: FlxEase.cubeOut}));
}


function popoutLyrics() {
    for(t in tweens)
        t.cancel();

    tweens.push(FlxTween.tween(lyrics, {y: 567, alpha: 0}, Conductor.stepCrochet / 250, {ease: FlxEase.cubeIn}));
    tweens.push(FlxTween.tween(background, {y: 562, alpha: 0}, Conductor.stepCrochet / 250, {ease: FlxEase.cubeIn}));
}


function stepHit()
{
	switch (curStep)
	{
		case 586:
			popinLyrics();
			lyrics.text = "That Right!";
		case 594:
			popoutLyrics();
		case 1723:
			popinLyrics();
			lyrics.text = "I";
		case 1731:
			lyrics.text = "I know";
		case 1738:
			lyrics.text = "I know you're";
		case 1746:
			lyrics.text = "I know you're out...";
		case 1753:
			lyrics.text = "THERE!";
		case 1763:
			lyrics.text = "Beyond";
		case 1771:
			lyrics.text = "Beyond her hallucination";
		case 1779:
			lyrics.text = "fight thru it all as we lost our path\nwhere hope has all but gone away as systems break,";
		case 1810:
			lyrics.text = "despair awaits you wear a mask,";
		case 1823:
			lyrics.text = "join her charade yet";
		case 1832:
			lyrics.text = "ALL THOSE AIN'T YOU";
		case 1844:
			lyrics.text = "don't give in and don't give up";
		case 1856:
			lyrics.text = "Cuz";
		case 1857:
			lyrics.text = "I";
		case 1868:
			lyrics.text = "I have found you once again";
		case 1889:
			lyrics.text = "always meant to be-";
		case 1896:
			lyrics.text = "TOGETHER TIL THE END";
		case 1913:
			lyrics.text = "won the battle,";
		case 1918:
			lyrics.text = "lost the war";
		case 1924:
			lyrics.text = "our obstacles cannot compare to this love";
		case 1939:
			lyrics.text = "so come take my hand!";
		case 1980:
			lyrics.text = "imasara zenbu kowase";
		case 2010:
			lyrics.text = "IMASARA ZENBU KOWASHITE";
		case 2071:
			popoutLyrics();
			
		
	}
	lyrics.screenCenter(FlxAxes.X);
	background.scale.set((lyrics.width / 2) + 16, 1);
}
