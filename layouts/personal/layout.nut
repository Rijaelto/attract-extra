//
// Attract-Mode Front-End - Personal basic
//

// Layout User Options
class UserConfig {
 </ label="Layout width", help="Select the width size in pixels", options="640" /> width="640";
 </ label="Layout height", help="Select the height size in pixels", options="480"/> height="480";
	
	
}
local my_config = fe.get_config();


// Layout Constants

local personal_width=my_config["width"].tointeger(); //ancho
local personal_height=my_config["height"].tointeger(); //alto

fe.layout.width = personal_width;
fe.layout.height = personal_height;

local layoutWidthUnit = personal_width/100 //divide width an height in 100 parts
local layoutheightUnit = personal_height/100 
	
// Layout Functions

	// Game name text. We do this in the layout as the frontend doesn't chop up titles with a forward slash
function gamename( index_offset ) 
{
 local s = split( fe.game_info( Info.Title, index_offset ), "(/[" );
 if ( s.len() > 0 ) return s[0];
 return "";
}
	
	
// Background Image

	
local bg = fe.add_image( "bg.jpg", 0, 0, personal_width, personal_height);
#fe.load_module( "fade" );
#local bg = FadeArt( "fanart", 0, 0, personal_width, personal_height);
// Posicionamiento del fondo

//  Bottom Background
local bottommask = fe.add_image ("titlemask.png", 0, layoutheightUnit*90, personal_width, 0);
//bottommask.height = personal_height - bottommask.y;layoutheightUnit*90
bottommask.set_rgb (0,0,0);

//  top Background
local topemask = fe.add_image ("titlemask.png", 0, 0, personal_width,layoutheightUnit*20);
//topemask.height = personal_height - topemask.y;
topemask.set_rgb (0,0,0);





// Bottom Background
/*
local bgRed=(18);
local bgGreen=(95);
local bgBlue=(147);

local lb = fe.add_text( "", 0, personal_height*0.8, personal_width, personal_height*0.231);
lb.set_bg_rgb( bgRed, bgGreen, bgBlue );
*/


//Snap or video

local videoPosX = layoutWidthUnit*3
local videoPosY = layoutheightUnit*28 
local videoWidth = layoutWidthUnit*(13*4)
local videoHeigth = layoutWidthUnit*(13*3)

local videoFramePosX = videoPosX - 3
local videoFramePosY = videoPosY - 3
local videoFrameWidth = videoWidth + 6 
local videoFrameHeigth = videoHeigth + 6

local videoFrame = fe.add_image ("black.png",videoFramePosX,videoFramePosY,videoFrameWidth,videoFrameHeigth);
local videoPreview = fe.add_artwork( "snap", videoPosX, videoPosY, videoWidth, videoHeigth );
videoPreview.trigger = Transition.EndNavigation;

//Flyer

local flyerPosX = layoutWidthUnit*68
local flyerPosY = layoutheightUnit*18
local flyerWidth = layoutWidthUnit*(8*3.5)
local flyerHeigth = layoutWidthUnit*(8*7.5)

local flyerFrame = fe.add_artwork( "flyer", flyerPosX, flyerPosY, flyerWidth, flyerHeigth);
local angulo = 5
flyerFrame.rotation = angulo;
flyerFrame.x = flyerFrame.x + (angulo*5);
flyerFrame.y = flyerFrame.y - angulo;  

local flyer = fe.add_clone( flyerFrame );
flyerFrame.x = flyerFrame.x - 3;
flyerFrame.y = flyerFrame.y - 3;
flyerFrame.width = flyerFrame.width + 6;
flyerFrame.height = flyerFrame.height + 6;
flyerFrame.set_rgb (0,0,0);


fe.load_module("animate");


//Animations 

 local move_shrink1 = {
    when = Transition.ToNewList ,property = "scale", start = 1.5, end = 1.0, time = 1500, tween = Tween.Bounce
 }

 local move_shrink2 = {
    when = Transition.ToNewSelection ,property = "scale", start = 1.5, end = 1.0, time = 1500, tween = Tween.Bounce
 } 



//Logo

local logoPosX = layoutWidthUnit*28
local logoPosY = layoutheightUnit*5
local logoWidth = layoutWidthUnit*50
local logoHeigth = layoutWidthUnit*(8*7.5)

local logoshadow = fe.add_artwork( "wheel", logoPosX, logoPosY, logoWidth, 0);
logoshadow.preserve_aspect_ratio = true;
logoshadow.set_rgb(0,0,0);
local logo = fe.add_clone( logoshadow );
logo.set_rgb (255,255,255);
logo.x = logo.x - 2;
logo.y = logo.y - 2; 

animation.add( PropertyAnimation( logoshadow, move_shrink1 ) );
animation.add( PropertyAnimation( logoshadow, move_shrink2 ) );
animation.add( PropertyAnimation( logo, move_shrink1 ) );
animation.add( PropertyAnimation( logo, move_shrink2 ) );



// Game title text

local gametitlePosX = layoutWidthUnit*3
local gametitlePosY = layoutheightUnit*95
local gametitleWidth = layoutWidthUnit*100
local gametitleHeigth = layoutWidthUnit*5


local gametitleshadow = fe.add_text( gamename ( 0 ), gametitlePosX, gametitlePosY, gametitleWidth, gametitleHeigth );
gametitleshadow.align = Align.Left;
gametitleshadow.set_rgb (0,0,0);
local gametitle = fe.add_text( gamename ( 0 ), gametitlePosX-1, gametitlePosY-1, gametitleWidth, gametitleHeigth );
gametitle.align = Align.Left;



//Animation
local move_gameListBG1 = {
    when = Transition.ToNewSelection ,property = "x", start = layoutWidthUnit*-30, end = 0, time = 1
 }

local move_gameListBG2 = {
    when = When.ToNewSelection ,property = "x", start =0, end = layoutWidthUnit*-30, time = 600, delay=1000
 } 


//list

local listBoxPosX = layoutWidthUnit*-30//layoutWidthUnit*3
local listBoxPosY = 0//layoutheightUnit*3
local listBoxWidth = layoutWidthUnit*30
local listBoxHeigth = layoutWidthUnit*60

// Game ListBox Background
local gameListBoxBackground = fe.add_image("titlemask.png", listBoxPosX, listBoxPosY, listBoxWidth, listBoxHeigth )
//gameListBoxBackground.set_bg_rgb( 50 * 0.75, 50 * 0.75, 50 * 0.75 )
//gameListBoxBackground.bg_alpha = 0
	
	
local gameListBox = fe.add_listbox( listBoxPosX, listBoxPosY, listBoxWidth, listBoxHeigth)
gameListBox.align = Align.Left
gameListBox.rows = 15
gameListBox.set_sel_rgb( 50, 50, 50 )
gameListBox.set_selbg_rgb( 0, 0, 0 )


animation.add( PropertyAnimation( gameListBoxBackground, move_gameListBG1 ) );
animation.add( PropertyAnimation( gameListBoxBackground, move_gameListBG2 ) );	
animation.add( PropertyAnimation( gameListBox, move_gameListBG1 ) );
animation.add( PropertyAnimation( gameListBox, move_gameListBG2 ) );		

	
// Transitions
fe.add_transition_callback( "fade_transitions" );
function fade_transitions( ttype, var, ttime ) {
	switch ( ttype ) {
		case Transition.ToNewList:
  		case Transition.ToNewSelection:
			gametitleshadow.msg = gamename ( var );
   			gametitle.msg = gametitleshadow.msg;
		break;
	}	
return false;
}








/*
fe.add_ticks_callback("flickertitle");
function flickertitle( ttime ) {
 if ( my_config["enable_flicker"] == "Yes" ) {
  grey = highrand( 1024 );
  gametitle.set_rgb (grey,grey,grey);
 } else {
  gametitle.set_rgb (255,255,255);
 }
}
*/


/*
local t = fe.add_artwork( "snap", 348, 152, 262, 262 );
t.trigger = Transition.EndNavigation;

t = fe.add_artwork( "marquee", 348, 64, 262, 72 );
t.trigger = Transition.EndNavigation;

local lb = fe.add_listbox( 32, 64, 262, 352 );
lb.charsize = 16;
lb.set_selbg_rgb( 255, 255, 255 );
lb.set_sel_rgb( 0, 0, 0 );
lb.sel_style = Style.Bold;

fe.add_image( "bg.png", 0, 0 );

local l = fe.add_text( "[DisplayName]", 0, 15, 640, 30 );
l.set_rgb( 200, 200, 70 );
l.style = Style.Bold;

// The following function tells the frontend to use our title
// text and listbox (created above) for any menus (exit menu,
// etc...
//
fe.overlay.set_custom_controls( l, lb );

// Left side:

l = fe.add_text( "[Title]", 30, 424, 320, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Left;

l = fe.add_text( "[Year] [Manufacturer]", 30, 441, 320, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Left;

l = fe.add_text( "[Category]", 30, 458, 320, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Left;

// Right side:

l = fe.add_text( "[ListEntry]/[ListSize]", 320, 424, 290, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Right;

l = fe.add_text( "[FilterName]", 320, 441, 290, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Right;

*/








/*




local lb = fe.add_listbox( 32, 64,0,0);
lb.charsize = 16;
lb.set_selbg_rgb( 255, 255, 255 );
lb.set_sel_rgb( 0, 0, 0 );
lb.sel_style = Style.Bold;


l = fe.add_text( "[Title]", 30, 100, 100, 16 );
l.set_rgb( 200, 200, 70 );
l.align = Align.Left;



*/