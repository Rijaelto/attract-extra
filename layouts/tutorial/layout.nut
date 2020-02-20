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

local personal_width=my_config["width"].tointeger(); //width of the layout based on the screen
local personal_height=my_config["height"].tointeger(); //heigth of the layout based on the screen

local layoutWidthUnit = personal_width/100 //divide width an height in 100 parts
local layoutheightUnit = personal_height/100 //divide heigth an height in 100 parts
	
fe.layout.width = personal_width; 
fe.layout.height = personal_height;
	
// Layout Functions

// Game name text. We do this in the layout as the frontend doesn't chop up titles with a forward slash
function gamename( index_offset ) 
{
 local s = split( fe.game_info( Info.Title, index_offset ), "(/[" );
 if ( s.len() > 0 ) return s[0];
 return "";
}
	
	
// Background Image

local background = fe.add_image("bg.jpg", 0, 0, personal_width, personal_height);


//Snap or video

// the position of the snap in layout units, it is more or less centered in the left of the screen with a little margin.

local videoPosX = layoutWidthUnit*3
local videoPosY = layoutheightUnit*28 
local videoWidth = layoutWidthUnit*(13*4) //it is to made it in 4:3
local videoHeigth = layoutWidthUnit*(13*3)

// the black frame of the video, it can be done with the other pos, but in this way is easy to understand
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
local flyerWidth = layoutWidthUnit*(8*3.5) //it is to made it in 3.5:7.5
local flyerHeigth = layoutWidthUnit*(8*7.5)

local flyerFrame = fe.add_artwork( "flyer", flyerPosX, flyerPosY, flyerWidth, flyerHeigth);
local angulo = 5
 flyerFrame.rotation = angulo;
 flyerFrame.x = flyerFrame.x + (angulo*5);
 flyerFrame.y = flyerFrame.y - angulo;  

// the same image but in black
local flyer = fe.add_clone( flyerFrame );
 flyerFrame.x = flyerFrame.x - 3;
 flyerFrame.y = flyerFrame.y - 3;
 flyerFrame.width = flyerFrame.width + 6;
 flyerFrame.height = flyerFrame.height + 6;
 flyerFrame.set_rgb (0,0,0); // black


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