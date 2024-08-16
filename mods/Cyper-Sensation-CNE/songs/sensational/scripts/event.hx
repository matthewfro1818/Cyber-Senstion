
var no:FlxSprite;
function postCreate()
     {
         

            no = new FlxSprite(0,0);		
            no.frames = Paths.getSparrowAtlas('stages/nonsense/nope');
            no.animation.addByPrefix('no', 'no', 24, false);
            no.screenCenter();
            no.cameras=[camHUD];
            no.visible=false;
            add(no);
             
     }
function bubble(type:String)
	{
		switch(type)
		{
			case 'show':
				no.alpha = 1;
				no.visible=true;
				no.animation.play("no", false);
                trace('show');
			case 'hide':
                trace('hide');
				FlxTween.tween(no, {alpha: 0.0}, 0.075, {ease: FlxEase.linear,
					onComplete: function(twn:FlxTween) {
						no.visible=false;
					}
				});
		}
	}
    var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
function beatHit()
    {
        switch(curBeat)
        {
            case 14,47,111,175,179,183,192,193,194,195,196:
                boyfriend.playAnim(FlxG.random.int(0, anims.length-1) +'miss', true);

        }
    }

function stepHit()
    {
        switch(curStep)
        {
            case 1:
                bubble('show');
            case 3:
                bubble('hide');
            case 6:
                bubble('hide');
            case 9:
                bubble('hide');
            case 12:
                bubble('hide');
            case 445:
                bubble('show');
            case 451:
                bubble('hide'); 
            case 700:
                bubble('show');
            case 704:
                bubble('hide');
            case 717:
                bubble('show');
            case 724:
                bubble('hide');
            case 732:
                
                bubble('show');
            case 744:
                bubble('hide');        
        }
    }
