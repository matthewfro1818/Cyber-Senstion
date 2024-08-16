var bf, taeyai:Character;
var bfstrum:StrumLine;
var focusBF:Bool = false;
var bfMid:FlxPoint = null;
var floatvalve:Float = 0;
var floatvalve2:Float = 0.30;

var flyed:Character;
var flystyle:String = '';
var floaty:Float = 0;
var floaty2:Float = 0;

var start:Bool = false;
public var spaceShader:FunkinShader;
public var glowShader:FunkinShader;
public var bloomShader:FunkinShader;
var spacetime:Float = 0;
//TO DO - Make object Seperate (Sprite Sheets), Character float around, Move Character on thier turn like old one
//curstep 257,513,909 (Nonsense float like he float)
var objectName = ['wall1','wall2','wall3','wall4','toad','sus','speaker','speaker2','spaker4','shelf','shelf2','paper','hat','hat2','hanger','gun','dino','clock','box','book','book3'];
var objectGroup:FlxTypedGroup;
var objPos = [[265.55,401.55],[1487.2,-43.3],[-87.65,-166.5],[-255.95,710.5],[1139.2,102.2],[1835.85,-835.25],[402.3,883.35],[639.2,97.8],[1390.3,323.25 /**no**/],[1660.3,408.25],[-233.05,392.65/**no**/],[-268.45,317.25],[1851.05,127.05],[1258.05,48.5],[982.7,456.1/**hanger**/],[906.95,336.9],[79.25,253.95],[326.06,-6.65],[-443.75,43.9],[1356,-236],[206.05,310.3],[206.05,310.3]];
var dadPos = [600,200];


function postCreate() {
    camGame.zoom = 0.4;

    debrisback.flipX = true;
    bg2.blend = 0;
    bg2.alpha = 0.5;
    bg2.flipX = true;
    bg3.blend = 0;
    bg3.alpha = 0.25;
    bg3.flipY = true;

    var index2 = members.indexOf(debrisback);
    objectGroup = new FlxTypedGroup();
    insert(index2, objectGroup);

    for(i in 0...objectName.length)
        {
            obj = new FunkinSprite(-300,-100);
            obj.scrollFactor.set(0.45, 0.45);
            obj.loadSprite(Paths.image("stages/nonsense/break/object"));
            obj.playAnim(objectName[i], false);
            obj.scale.set(0.8,0.8);
            obj.setPosition(objPos[i][0], objPos[i][1]);
    
            obj.ID = i;
            objectGroup.add(obj);
           // trace(obj);
        }




    var index = members.indexOf(debris);
    flyed = dad;
    bf = new Character(1340, debrisback.y - 550, 'bf', true);
    bf.scrollFactor.set(0.8, 0.8);
    insert(index, bf);
    



    bfMid = bf.getGraphicMidpoint();


    for(s in strumLines.members[2]) {
        s.cameras = [camGame];
        s.scrollFactor.set(0.8, 0.8);
        s.alpha = 0.4;
    }


    debris2.y += 100;
    debris.y -= 150;
    gf.visible = false;
    flystyle = 'hover';
    trace(flystyle);

    camGame.scroll.set(453,310);
    strumLines.members[2].characters = [bf];

    //Shader
    if(FlxG.save.data.ShaderHigh) {
    spaceShader = new FunkinShader(Assets.getText(Paths.fragShader("space")));
    bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
    }
    glowShader = new FunkinShader(Assets.getText(Paths.fragShader("edgeglow")));

    if(FlxG.save.data.ShaderHigh) {
    var index = members.indexOf(bg2);
    red = new FlxSprite(-800, -800);
	red.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFdb0000);
	red.scrollFactor.set(0.1, 0.1);
	red.alpha = 0.5;
	red.blend = 0;
    insert(index,red);
    }

    forhead = new FlxSprite(-800, -800);
	forhead.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFdb0000);
	forhead.scrollFactor.set(0.8, 0.8);
	forhead.alpha = 0.1;
	forhead.blend = 0;
    add(forhead);

    if(FlxG.save.data.ShaderHigh) {
    red.shader = spaceShader;  
    forhead.shader = spaceShader;  
    }

    bg.shader = glowShader;  
    bg2.shader = glowShader;  
    bg3.shader = glowShader; 

    
    bg.shader = bloomShader;  
    bg2.shader = bloomShader;  
    bg3.shader = bloomShader;
}

function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.8}, 2, {ease: FlxEase.cubeIn});
        }
   
}

function update(elapsed:Float) {
    for(s in strumLines.members[2]) {
        s.x = bfMid.x + (Note.swagWidth * (s.ID - 1.5)) + (150 * Math.sin((curBeatFloat + s.ID) * Math.PI / 16));
        s.y = bfMid.y + (20 * Math.sin((curBeatFloat + s.ID) * Math.PI / 4));
    }
    switch (flystyle)
    {
        case 'hover':
            
            floaty += 0.03 * elapsed * 120;
            flyed.y += Math.sin(floaty) * 1.5 * elapsed * 120;
        case 'fly':
            floaty += 0.04 * elapsed * 120;
            floaty2 -= 0.009 * elapsed * 120;
            flyed.y -= Math.sin(floaty) * 2.2;
            flyed.x -= Math.cos(floaty2) * 2.6 * elapsed * 120;
    }

    spacetime += elapsed;
    
    if(FlxG.save.data.ShaderHigh) {
    red.shader.iTime = spacetime;
    forhead.shader.iTime = spacetime;
    }
    bloomShader.iTime = spacetime;
    glowShader.iTime = spacetime;

    var cool = objectGroup.members[20];
    if (FlxG.keys.pressed.J) cool.x -= 5;
    if (FlxG.keys.pressed.L) cool.x += 5;
    if (FlxG.keys.pressed.I) cool.y -= 5;
    if (FlxG.keys.pressed.K) cool.y += 5;
    if (FlxG.keys.pressed.O) {
        trace(cool); trace(cool.animation.curAnim.frameName);
    }
}

function stepHit()
    {
        switch(curStep)
        {
            case 257,899:
                flystyle = 'fly';
            case 640:
                dad.x = lerp(dad.x,dadPos[0],0.125);
                dad.y = lerp(dad.y,dadPos[1],0.125);
                
                flystyle = 'hover';
        }
    }

function postUpdate(elapsed:Float)
    {
        var sinvalve = Math.sin(floatvalve);
        var cosvalve = Math.cos(floatvalve);
        var sinvalve2 = Math.sin(floatvalve2);
        bg.alpha = bg2.alpha = bg3.alpha = 1 + (0.25 * Math.sin(Math.PI * curBeatFloat / 4));

        floatvalve += 0.05 * elapsed * 120;
        floatvalve2 -= 0.01 * elapsed * 120;

        debris.x = dad.x - 150;
        debris2.x = boyfriend.x - 100;
        debrisback.x = bf.x - 130;


        boyfriend.y += sinvalve * elapsed * 120;
        bf.y += cosvalve * elapsed * 120;
        debris.y = dad.y + 470;
        debris2.y = boyfriend.y + 620;
        debrisback.y = bf.y + 570;
    }
    

function onStrumCreation(event)
{
    if (event.player == 2)
        event.cancelAnimation();

}

function onPostNoteCreation(event)
    {

        if(event.strumLineID == 2)
            {
                event.note.alpha = 0.4;
            }
              
            

    }

