import funkin.options.type.Checkbox;
import flixel.tweens.FlxTween;
import funkin.menus.MainMenuState;
import flixel.util.typeLimit.OneOfTwo;
import funkin.options.TreeMenu;
import funkin.options.OptionsScreen;
import funkin.options.OptionsMenu;
import funkin.options.type.OptionType;
import funkin.options.type.TextOption;
import funkin.options.categories.GameplayOptions;
import funkin.options.categories.AppearanceOptions;
import funkin.options.categories.MiscOptions;
import funkin.backend.MusicBeatState;
import funkin.backend.MusicBeatSubstate;
import funkin.options.keybinds.KeybindsOptions;
import mobile.funkin.menus.MobileControlSelectSubState;
import funkin.options.categories.MobileOptions;
import mobile.funkin.backend.TouchFunctions;

public var submode:Bool = true;
public var thaimode:Bool = false;
public var useDownscroll:Bool = false;

//IF you wonder why i'm not using like a json or anything that not array like this
//That because i never actually finished this System since it's got canned
//So There only 2 Languages
var time:Float = 0;
var optionShit = ["downscroll",'Subtitle','Language', 'MiddleScroll', 'High-End Mode', 'BotPlay' 'Controls'];
var optionShitth = ["เลื่อนลง",'ซับไตเติ้ล','ภาษา', 'หยุดอัตโนมัติ', 'เฟรมเรต', 'เทคโนโลยีลบรอยหยัก' 'ตั้งปุ่ม'];
var langmode = ['EN','TH'];
var dubmode = ['EN'];
var saveShit = [Options.downscroll,FlxG.save.data.useSubs,langmode[0], FlxG.save.data.MiddleScroll, FlxG.save.data.ShaderHigh, FlxG.save.data.BotPlay];
var descShit:FunkinText;
var frameratess = FlxG.drawFramerate;
function postCreate()
{
    remove(members[0]);

    remove(members[1]);
    remove(members[2]);
    remove(members[3]);
    remove(members[4]);

    if(FlxG.save.data.thaiSub)
    {
        saveShit[2] = dubmode[1];
    }

    if(FlxG.save.data.thaiDub)
    {
        saveShit[3] = dubmode[1];
    }

     if(FlxG.save.data.thaiSub == null)
    {
            FlxG.save.data.thaiSub = false;
    }

    if(FlxG.save.data.useSubs == null)
    {
        FlxG.save.data.useSubs = true;
    }
    
    if(FlxG.save.data.MiddleScroll == null)
    {
        FlxG.save.data.MiddleScroll = true;
    }
    
    if(FlxG.save.data.ShaderHigh == null)
    {
        FlxG.save.data.ShaderHigh = true;
    }
    
    if(FlxG.save.data.BotPlay == null)
    {
        FlxG.save.data.BotPlay = true;
    }

    bglol = new FlxSprite(-800, -800);
    bglol.makeGraphic(FlxG.width, FlxG.height, 0xFF616161);
    bglol.scrollFactor.set(0, 0);
    bglol.screenCenter(FlxAxes.XY);
    bgShader = new CustomShader('bgMenu');
    bglol.shader = bgShader;
    add(bglol);

    overlay = new FlxSprite(0, 0);
    overlay.loadGraphic(Paths.image('menus/freeplay/overlay'));
    overlay.antialiasing = true;
    overlay.scrollFactor.set(0, 0);
    overlay.updateHitbox();
    add(overlay);

    set = new FunkinText(5, FlxG.height - 2, 0, 'Setting');
    set.scrollFactor.set();
    set.y = 20;
    set.size = 40;
    set.font = Paths.font('freeplay.ttf');
    if(FlxG.save.data.thaiSub){set.text = 'ตั้งค่า'; set.font = Paths.font('thai-font.ttf');}

    set.screenCenter(FlxAxes.X);
    add(set);

    descShit = new FunkinText(5, FlxG.height - 2, 0, 'Desc:');
    descShit.scrollFactor.set();
    descShit.size = 30;
    descShit.font = Paths.font('freeplay.ttf');
    if(FlxG.save.data.thaiSub){descShit.font = Paths.font('thai-font.ttf');}

    descShit.y -= descShit.height;
    add(descShit);


    grpOptions = new FlxTypedGroup();
	add(grpOptions);

    grpBool = new FlxTypedGroup();
	add(grpBool);

    if(FlxG.save.data.thaiSub){whatyoupick = optionShitth;}else{whatyoupick = optionShit;}


    for (i in 0...optionShit.length)
		{
			opText = new FunkinText(50, (0 * i) + 200,0, whatyoupick[i], 42);
            opText.alignment = 'LEFT';
            opText.font = Paths.font('freeplay.ttf');
            if(FlxG.save.data.thaiSub){opText.font = Paths.font('thai-font.ttf');}

			opText.y = 100 + i * 90;
            opText.ID = i;
            if(opText.ID == 6){
                opText.x *= 17;
                opText.y = 100;
            }

            
          
            grpOptions.add(opText);
		}
    for (i in 0...optionShit.length)
    {
        boolText  = new FunkinText(grpOptions.members[0].x * 10, (0 * i) + 200,0, '< '+saveShit[i]+' >', 42);
        boolText.alignment = 'CENTER';
        boolText.font = Paths.font('freeplay.ttf');
        if(FlxG.save.data.thaiSub){boolText.font = Paths.font('thai-font.ttf');}

        boolText.y = 100 + i * 90;

        
        boolText.ID = i;
        if(boolText.ID == 6){boolText.text = '';} //Keybinds
        grpBool.add(boolText);
    }
    changeItem(0);
    addVirtualPad('LEFT_FULL', 'A_B');




}
var keyrn:Bool = false;


function update(elapsed:Float)
{
    bgShader.iTime = (time += elapsed);
    FlxG.mouse.visible = false;
    if(!keyrn)
    {
        if (controls.UP_P) {changeItem(-1);}
        if (controls.DOWN_P) {changeItem(1);}
        if (controls.LEFT_P) {changeOp(-1);}
        if (controls.RIGHT_P) {changeOp(1);}
        if (FlxG.keys.justPressed.R) {FlxG.resetState();}
    }
    
    #if mobile
    if(!keyrn)
    {
    #end
    if (controls.BACK) {
        if(keyrn)
            {
                keyrn = false;
            }
            else
            {
                exitha();
            }
    }

    if(controls.ACCEPT && curSelected == 6 && !keyrn) 
    {
        #if mobile
        openSubState(new MobileControlSelectSubState());
        addVirtualPad('NULL', 'NULL');
        #else
        openSubState(new KeybindsOptions()); 
        #end
        // keyrn = true;
    }
    #if mobile
    }
    #end

    frameratess = FlxG.drawFramerate;
}
var curSelected:Int = 0;
var curSelected2:Int = 0;
var curSelected3:Int = 0;
var selected = false;
function changeItem(huh:Int = 0)
{
        var value = FlxMath.wrap(curSelected + huh, 0, optionShit.length-1);
		curSelected = value;
        trace(curSelected);
        grpOptions.forEach(function(t:FunkinText) {
            if (t.ID == curSelected)
            {
                FlxTween.tween(t, {alpha: 1}, 0.2);
                trace(t.text);
            }
            else
            {
                FlxTween.tween(t, {alpha: 0.5}, 0.2);
            }
        });

        descShit.size = 30;

        switch(curSelected)
        {
            case 0:
                descShit.text = 'If checked, notes go Down instead of Up, simple enough.';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                {
                    descShit.text = 'ถ้าติ๊ก โน๊ตจะเลื่อนลงแทนขึ้น. แค่นั้นแหละ';
                    descShit.font = Paths.font('thai-font.ttf');
                }
            case 1:
                descShit.text = 'If checked, subtitle appear';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                    {
                        descShit.text = 'ถ้าติ๊ก ซับไตเติ้ลจะขึ้น';
                        descShit.font = Paths.font('thai-font.ttf');
                    }
            case 2:
                descShit.text = 'Choose Language';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                    {
                        descShit.text = 'เลือกภาษา';
                        descShit.font = Paths.font('thai-font.ttf');
                    }
            case 3:
                descShit.text = 'If checked, player notes go Center instead of Left, simple enough.';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                    {
                        descShit.text = 'เกมหยุดเมื่ออยู่หน้าโปรแกรมอื่น';
                        descShit.font = Paths.font('thai-font.ttf');
                    }
            case 4:
                descShit.text = 'If checked, All Shaders are enabled. (Better Experience)';
                descShit.font = Paths.font('freeplay.ttf');
            case 5:
                descShit.text = 'If unchecked, it removes the A button in Playstate.';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                    {
                        descShit.text = 'เกมหยุดเมื่ออยู่หน้าโปรแกรมอื่น';
                        descShit.font = Paths.font('thai-font.ttf');
                    }
            case 6:
                #if desktop
                descShit.text = 'Keybinds';
                #else
                descShit.text = 'Choose which control to play with (hitbox, vpad, custom...).';
                descShit.font = Paths.font('freeplay.ttf');
                if(FlxG.save.data.thaiSub)
                    {
                        descShit.text = 'ตั้งปุ่น';
                        descShit.font = Paths.font('thai-font.ttf');
                    }
        }


		FlxG.sound.play(Paths.sound('menu/scroll'), 0.7);
}

function changeOp(huh:Int = 0)
{
            if(curSelected == 2)
            {
                var value = FlxMath.wrap(curSelected2 + huh, 0, langmode.length-1);
                curSelected2 = value;
                trace(curSelected2 + ' | ' + langmode[curSelected2]);
                grpBool.members[2].text = '< ' + langmode[curSelected2] + ' >';
                if(curSelected2 == 1) {FlxG.save.data.thaiSub = true;}
                else{FlxG.save.data.thaiSub = false;}
       
                if(FlxG.save.data.thaiSub){set.text = 'ตั้งค่า'; set.font = Paths.font('thai-font.ttf');}
                else{set.text = 'Setting';  set.font = Paths.font('freeplay.ttf');}
                set.screenCenter(FlxAxes.X);
                if(FlxG.save.data.thaiSub)
                {
                    for (i in 0...optionShit.length)
                    {
                            grpOptions.members[i].text = optionShitth[i]; grpOptions.members[i].font = Paths.font('thai-font.ttf');
                            grpBool.members[i].font = Paths.font('thai-font.ttf');
                    }
                }
                else
                {
                    for (i in 0...optionShit.length)
                        {
                            grpOptions.members[i].text = optionShit[i];  grpOptions.members[i].font = Paths.font('freeplay.ttf');
                            grpBool.members[i].font = Paths.font('freeplay.ttf');
                        }
                }
                descShit.size = 30;
                switch(curSelected)
                {
                    case 0:
                        descShit.text = 'If checked, notes go Down instead of Up, simple enough.';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                        {
                            descShit.text = 'ถ้าติ๊ก โน๊ตจะเลื่อนลงแทนขึ้น. แค่นั้นแหละ';
                            descShit.font = Paths.font('thai-font.ttf');
                        }
                    case 1:
                        descShit.text = 'If checked, subtitle appear';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                            {
                                descShit.text = 'ถ้าติ๊ก ซับไตเติ้ลจะขึ้น';
                                descShit.font = Paths.font('thai-font.ttf');
                            }
                    case 2:
                        descShit.text = 'Choose Language';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                            {
                                descShit.text = 'เลือกภาษา';
                                descShit.font = Paths.font('thai-font.ttf');
                            }
                    case 3:
                        descShit.text = 'May be broken in songs with more characters (This option is wip)';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                            {
                                descShit.text = 'เกมหยุดเมื่ออยู่หน้าโปรแกรมอื่น';
                                descShit.font = Paths.font('thai-font.ttf');
                            }
                    case 4:
                        descShit.text = 'PC MASTER RACE';
                        descShit.font = Paths.font('freeplay.ttf');
                     case 5:
                        descShit.text = 'Device Type';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                            {
                                descShit.text = 'เกมหยุดเมื่ออยู่หน้าโปรแกรมอื่น';
                                descShit.font = Paths.font('thai-font.ttf');
                            }
                    case 6:
                        descShit.text = 'Controls';
                        descShit.font = Paths.font('freeplay.ttf');
                        if(FlxG.save.data.thaiSub)
                            {
                                descShit.text = 'ตั้งปุ่น';
                                descShit.font = Paths.font('thai-font.ttf');
                            }
                }
            }
            else if(curSelected == 6)
            {
                grpBool.members[6].text = '';
            }
            else
            {
                saveShit[curSelected] = !saveShit[curSelected];
                grpBool.forEach(function(t:FunkinText) {
                    if (t.ID == curSelected)
                    {
                        t.text = '< ' + saveShit[curSelected] + ' >';
                    }
                });
            }

    
    
            FlxG.sound.play(Paths.sound('menu/scroll'), 0.7);
}

function exitha()
{
    Options.downscroll = saveShit[0];
    FlxG.save.data.MiddleScroll = saveShit[3];
    FlxG.save.data.ShaderHigh = saveShit[4];
    FlxG.save.data.BotPlay = saveShit[5];
    FlxG.save.data.useSubs = saveShit[1];
    Options.save();
    Options.applySettings();
    if(curSelected2 == 0) {FlxG.save.data.thaiSub = false;} else {FlxG.save.data.thaiSub = true;}
    FlxG.save.data.thaiDub = false;
    
    FlxG.save.flush();
    trace('Subtitle: ' + FlxG.save.data.useSubs);
    trace('MiddleScroll: ' + FlxG.save.data.MiddleScroll);
    trace('High-End Mode: ' + FlxG.save.data.ShaderHigh);
    trace('BotPlay: ' + FlxG.save.data.BotPlay);
    trace('Language: ' + FlxG.save.data.thaiSub + ' | ' + langmode[curSelected2]);
    
    new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            exit();
        });

    
}

function __changeFPS(change:Float)
	{
        if(FlxG.drawFramerate <= 30 && change == -1 || FlxG.drawFramerate >= 240 && change == 1 ) return;
		FlxG.drawFramerate = FlxG.updateFramerate += Std.int(change*10);
	}