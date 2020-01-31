// Layout by cools / Arcade Otaku
// http://www.arcadeotaku.com
// Uses snap, logo and flyer images. Will use title images if desired.
// 
// History/changes: too many. I use this so it's forever WIP
///////////////////////////////////////////////////////// 
// Layout User Options
class UserConfig {
 </ label="Background Image", help="Choose snap/video snap, title, user image (bg.jpg in layout folder) or no background", options="snap,video,title,fanart,user,none" /> bg_image = "user";
 </ label="Preview Image", help="Choose snap/video snap, title or none.", options="snap,video,title,none" /> preview_image = "none";
 </ label="Title Flicker", help="Flicker the game title", options="Yes,No" /> enable_flicker="Yes";
 </ label="Display List Name", help="Show ROM list name", options="Yes,No" /> enable_list="Yes";
 </ label="Display Filter Name", help="Show filter name", options="Yes,No" /> enable_filter="Yes";
 </ label="Display Entries", help="Show quantity of ROMs in current filter", options="Yes,No" /> enable_entries="Yes";
 </ label="Display Category", help="Show game category", options="Yes,No" /> enable_category="Yes";
 </ label="Flyer Angle", help="Rotation of the game flyer in degrees (0-15)", options="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" /> flyer_angle="5";
 </ label="Display Flyer", help="Hides the flyer/game box.", options="Yes,No" /> enable_flyer="Yes";
 </ label="Logo Position", help="Positions the logo on screen.", options="Left,Centre,Right" /> logo_position="Left";
 </ label="width", help="Select the width size in pixels", 
	options="330,329,328,327,326,325,324,323,322,321,320,319,318,317,316,315,314,313,312,311,310" /> width="320";
 </ label="height", help="Select the height size in pixels", options="250,249,248,247,246,245,244,243,242,241,240,239,238,237,236,235,334,233,232,231,230"/> height="240";
}
local my_config = fe.get_config();
// Layout Constants
fe.layout.width = my_config["width"].tointeger(); //ancho
fe.layout.height = my_config["height"].tointeger(); //alto
local bgx=((fe.layout.width/8)*-1); 
local bgy=((fe.layout.height/8)*-1);
local bgw=((fe.layout.width/4)*5);
local bgh=((fe.layout.height/4)*5);
local snx=10;
local sny=35;
local snw=170;
local snh=127;
// Game name text. We do this in the layout as the frontend doesn't chop up titles with a forward slash
function gamename( index_offset ) {
 local s = split( fe.game_info( Info.Title, index_offset ), "(/[" );
 if ( s.len() > 0 ) return s[0];
 return "";
}
// Copyright text
function copyright( index_offset ) {
 local s = split( fe.game_info( Info.Manufacturer, index_offset ), "(" );
 if ( s.len() > 0 ) return "� " + fe.game_info( Info.Year, index_offset ) + " " + s[0];
 return "";
}
// Returns a random number below 255. Set randrange to higher values to hit closer to 255
function highrand( randrange ) {
 return 255-(rand()/randrange);
}
// Random high colour values
local red = highrand( 255 );
local green = highrand( 255 );
local blue = highrand( 255 );
local grey = highrand( 1024 );
/////////////////////////////////////////////////////////
// On Screen Objects
// Background Image
if ( my_config["bg_image"] == "video") {
 local bg = fe.add_artwork( "snap", bgx, bgy, bgw, bgh );
}
if ( my_config["bg_image"] == "snap") {
 local bg = fe.add_artwork( "snap", bgx, bgy, bgw, bgh );
 bg.movie_enabled = false;
}
if ( my_config["bg_image"] == "title") {
 local bg = fe.add_artwork( "title", bgx, bgy, bgw, bgh );
}
if ( my_config["bg_image"] == "fanart") {
 fe.load_module( "fade" );
 local bg = FadeArt( "fanart", bgx, bgy, bgw, bgh );
}
if ( my_config["bg_image"] == "user") {
 local bg = fe.add_image( "bg.jpg", bgx, bgy, bgw, bgh );
}
local bgmask = fe.add_image ("bgmask.png", 0, 0, fe.layout.width, fe.layout.height);
// Preview image
if ( my_config["preview_image"] == "video") {
 local previewoutline = fe.add_image ("black.png",snx-1,sny-1,snw+2,snh+2);
 local preview = fe.add_artwork( "snap", snx, sny, snw, snh);
}
if ( my_config["preview_image"] == "snap") {
 local previewoutline = fe.add_image ("black.png",snx-1,sny-1,snw+2,snh+2);
 local preview = fe.add_artwork( "snap", snx, sny, snw, snh);
 preview.movie_enabled = false;
}
if ( my_config["preview_image"] == "title") {
 local previewoutline = fe.add_image ("black.png",snx-1,sny-1,snw+2,snh+2);
 local preview = fe.add_artwork( "snap", snx, sny, snw, snh);
}
// Game title background
local titlemask = fe.add_image ("titlemask.png", 0, 198, fe.layout.width, 0);
titlemask.height = fe.layout.height - titlemask.y;
titlemask.set_rgb (0,0,0);
// Flyer image
if ( my_config["enable_flyer"] == "Yes") {
 local flyeroutline = fe.add_artwork( "flyer", 160, 30, 130, 170);
 flyeroutline.preserve_aspect_ratio = true;
 flyeroutline.rotation = my_config["flyer_angle"].tofloat();
 flyeroutline.x = flyeroutline.x + (my_config["flyer_angle"].tointeger()*5);
 flyeroutline.y = flyeroutline.y - my_config["flyer_angle"].tointeger();  
 local flyer = fe.add_clone( flyeroutline );
 flyeroutline.x = flyeroutline.x - 1;
 flyeroutline.y = flyeroutline.y - 1;
 flyeroutline.width = flyeroutline.width + 2;
 flyeroutline.height = flyeroutline.height + 2;
 flyeroutline.set_rgb (0,0,0);
}
// Game title text
local gametitleshadow = fe.add_text( gamename ( 0 ), 6, 201, fe.layout.width-5, 16 );
gametitleshadow.align = Align.Left;
gametitleshadow.set_rgb (0,0,0);
local gametitle = fe.add_text( gamename ( 0 ), 5, 200, fe.layout.width-5, 16 );
gametitle.align = Align.Left;
// Make the game title flicker. Added bonus - currently fixes graphical corruption and screen not refreshing bugs.
fe.add_ticks_callback("flickertitle");
function flickertitle( ttime ) {
 if ( my_config["enable_flicker"] == "Yes" ) {
  grey = highrand( 1024 );
  gametitle.set_rgb (grey,grey,grey);
 } else {
  gametitle.set_rgb (255,255,255);
 }
}
local copy = fe.add_text( copyright ( 0 ), 5, 217, fe.layout.width - 5, 10 );
copy.align = Align.Left;
// Game logo image
local logox = 7;
switch ( my_config["logo_position"] ) {
 case "Centre":
  logox = 62;
  break;
 case "Right":
  logox = 113;
}
local logoshadow = fe.add_artwork( "wheel", logox, 117, 200, 0);
logoshadow.preserve_aspect_ratio = true;
logoshadow.set_rgb(0,0,0);
local logo = fe.add_clone( logoshadow );
logo.set_rgb (255,255,255);
logo.x = logo.x - 2;
logo.y = logo.y - 2; 
// Loading screen message.
local message = fe.add_text("Cagando...",0,100,fe.layout.width,40);
message.alpha = 0;
// Optional game texts
local romlist = fe.add_text( "[ListTitle]", 2, 10, 315, 10 );
romlist.align = Align.Left;
local filter = fe.add_text( "[ListFilterName]", 2, 10, 315, 10 );
filter.align = Align.Right;
local entries = fe.add_text( "[ListEntry]/[ListSize]", 2, 20, 315, 10 );
entries.align = Align.Right;
local cat = fe.add_text( fe.game_info (Info.Category), 2, 217, 315, 10 );
cat.align = Align.Right;
// Switch texts on and off
if ( my_config["enable_category"] == "Yes" ) { cat.visible = true; } else { cat.visible = false; }
if ( my_config["enable_list"] == "Yes" ) { romlist.visible = true; } else { romlist.visible = false; }
if ( my_config["enable_filter"] == "Yes" ) { filter.visible = true; } else { filter.visible = false; }
if ( my_config["enable_entries"] == "Yes" ) { entries.visible = true; } else { entries.visible = false; }
// Transitions
fe.add_transition_callback( "fade_transitions" );
function fade_transitions( ttype, var, ttime ) {
 switch ( ttype ) {
  case Transition.ToNewList:
  case Transition.ToNewSelection:
   gametitleshadow.msg = gamename ( var );
   gametitle.msg = gametitleshadow.msg;
   copy.msg = copyright ( var );
   cat.msg = fe.game_info (Info.Category, var);  
   red = highrand( 255 );
   green = highrand( 255 );
   blue = highrand( 255 );
   romlist.set_rgb (red,green,blue);
   filter.set_rgb (red,green,blue);
   entries.set_rgb (red,green,blue);
   copy.set_rgb (red,green,blue);
   cat.set_rgb (red,green,blue);
   break;
  case Transition.FromGame:
   if ( ttime < 255 ) {
    foreach (o in fe.obj) o.alpha = ttime;
    message.alpha = 0;     
    return true;
   } else {
    foreach (o in fe.obj) o.alpha = 255;
    message.alpha = 0;
   }
   break;  
  case Transition.EndLayout:
   if ( ttime < 255 ) {
    foreach (o in fe.obj) o.alpha = 255 - ttime;
    message.alpha = 0; 
    return true;
   } else {
    foreach (o in fe.obj) o.alpha = 255;
    message.alpha = 0;
   }
   break;
  case Transition.ToGame:
   if ( ttime < 255 ) {
    foreach (o in fe.obj) o.alpha = 255 - ttime;
    message.alpha = ttime;
    return true;
   }   
   break; 
  }
 return false;
}
