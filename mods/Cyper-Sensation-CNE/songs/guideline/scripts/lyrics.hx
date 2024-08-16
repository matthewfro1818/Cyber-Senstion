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
		case 191:
			popinLyrics();
			lyrics.text = "We're going to learn how to use this device, listen.";
		case 223:
			popoutLyrics();
		case 255:
			popinLyrics();
			lyrics.text = "Come on now, let me explain how easy it is.";
		case 288:
			popoutLyrics();
		case 320:
			popinLyrics();
			lyrics.text = "So press this button and it will take you to other place.";
		case 352:
			popoutLyrics();
		case 382:
			popinLyrics();
			lyrics.text = "If you want some help";
		case 393:
			lyrics.text = "you can call me by pressing this button";
		case 414:
			lyrics.text = "and I... and I'll be there.";
		case 431:
			popoutLyrics();
		case 447:
			popinLyrics();
			lyrics.text = "If you want to speak, you can use translate.";
		case 479:
			lyrics.text = "Here! Try it out and you will see";
		case 497:
			lyrics.text = "that you no more bep bop.";
		case 511:
			lyrics.text = "it will not gonna work because it my language";
		case 543:
			lyrics.text = "there is no way you gonna ";
		case 559:
			lyrics.text = "oh! your right i can speak";
		case 576:
			lyrics.text = "If you wanna ask something";
		case 584:
			lyrics.text = "please just tell me";
		case 587:
			lyrics.text = "and i will tell you";
		case 596:
			lyrics.text = "anything for you";
		case 608:
			lyrics.text = "oh dear please don't be shy";
		case 615:
			lyrics.text = "cause i will help you out no matter what";
		case 629:
			lyrics.text = "i'm here for you ";
		case 640:
			lyrics.text = "if i have question i will just ask you";
		case 652:
			lyrics.text = "and you will telling me everything";
		case 665:
			lyrics.text = "to me";
		case 672:
			lyrics.text = "well can you please turn this translate thing off";
		case 685:
			lyrics.text = "cause my voice sound so weird";
		case 695:
			lyrics.text = "not the same";
		case 704:
			lyrics.text = "so you understand how this work now";
		case 720:
			lyrics.text = "You will have so much fun with it";
		case 734:
			lyrics.text = "and i will help support your back don't scare";
		case 752:
			lyrics.text = "because";
		case 755:
			lyrics.text = "i'm Tiny at your service";
		case 765:
			popoutLyrics();
		case 832:
			popinLyrics();
			lyrics.text = "We're going to learn how to use this device, listen.";
		case 864:
			popoutLyrics();
		case 896:
			popinLyrics();
			lyrics.text = "Come on now, let me explain how easy it is.";
		case 928:
			popoutLyrics();
	}
	lyrics.screenCenter(FlxAxes.X);
	background.scale.set((lyrics.width / 2) + 16, 1);
}
