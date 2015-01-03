#define GMUI_MASTER_INI
//initialize global UI variables
globalvar gmui_button_count, gmui_scrollpane_count, gmui_textfield_count, gmui_radiobutton_count, gmui_checkbox_count, gmui_ddmenu_count;

gmui_button_count = 0;
//gmui_scrollpane_count = 0;
gmui_textfield_count = 0;
gmui_radiobutton_count = 0;
gmui_checkbox_count = 0;
//gmui_ddmenu_count = 0;


//create all UI object types
globalvar gmui_button, gmui_scrollpane, gmui_textfield, gmui_radiobutton, gmui_checkbox, gmui_ddmenu;

gmui_button = object_add();
//gmui_scrollpane = object_add();
gmui_textfield = object_add();
gmui_radiobutton = object_add();
gmui_checkbox = object_add();
//gmui_ddmenu = object_add(); //drop down menu


//initialize UI objects

GMUI_button_ini();
//GMUI_scrollpane_ini();
GMUI_textfield_ini();
GMUI_radiobutton_ini();
GMUI_checkbox_ini();
//GMUI_ddmenu_ini();

#define GMUI_button_ini
var w, h; // width and height of default sprites for buttons
var btnspr_up, btnspr_over, btnspr_down, btnspr_msk; //different sprites for the button (these are the variables for the surfaces)

w = 120;
h = 32;

//add code to the button objects

object_event_add( gmui_button, ev_create, 0, "
gmui_button_count += 1;
button_id = gmui_button_count;
spr_up = global.gmui_button_sprite_up;   
spr_over = global.gmui_button_sprite_over;  
spr_down = global.gmui_button_sprite_down;
spr_mask = global.gmui_button_sprite_mask;
btn_text = '';
mask_index = spr_mask;
sprite_index = spr_up;
click = false;
isDown = false;
pressed = false;
released = false;
");
object_event_add( gmui_button, ev_step, 0, "
pressed = false;
released = false;
if (collision_point( mouse_x, mouse_y, gmui_button, false, false ) != id) {
    sprite_index = spr_up;
    isDown = false;
}
else if (click == false) {
    sprite_index = spr_over;
    isDown = false;
}
else {
    sprite_index = spr_down;
    isDown = true;
}
if (click == false && sprite_index == spr_over) {
    if (mouse_check_button_pressed( mb_left )) {
        click = true;
        pressed = true;
    }
}                                   
if (mouse_check_button_released( mb_left )) {
    click = false;
    if ( sprite_index = spr_down) {
        released = true;
    }
}
");       
object_event_add( gmui_button, ev_draw, 0, "
draw_sprite( sprite_index, -1, x, y );
draw_set_halign( fa_center );
draw_set_valign( fa_center );
if (variable_local_exists('btn_font')) {
    draw_set_font( btn_font );
}
draw_text( x + sprite_get_width(sprite_index)/2, y + sprite_get_height(sprite_index)/2, btn_text );
");      

//create up sprite

btnspr_up = surface_create( w + 1, h + 1 );
surface_set_target( btnspr_up );
draw_set_color( c_gray );
draw_set_alpha( .5 );
draw_roundrect( 0, 0, w, h, 0 );
draw_set_color( c_black );
draw_set_alpha( 1 );
draw_roundrect( 0, 0, w, h, 1 );
surface_reset_target();
global.gmui_button_sprite_up = sprite_create_from_surface( btnspr_up, 0, 0, w + 1, h + 1, 0, 0, 0, 0 );
//create mask sprite
global.gmui_button_sprite_mask = sprite_create_from_surface( btnspr_up, 0, 0, w + 1, h + 1, 1, 1, 0, 0 );
surface_free( btnspr_up );


//create over sprite

btnspr_over = surface_create( w + 1, h + 1 );
surface_set_target( btnspr_over );
draw_set_color( c_white );
draw_set_alpha( .8 );
draw_roundrect( 0, 0, w, h, 0 );
draw_set_color( c_black );
draw_set_alpha( 1 );
draw_roundrect( 0, 0, w, h, 1 );
surface_reset_target();
global.gmui_button_sprite_over = sprite_create_from_surface( btnspr_over, 0, 0, w + 1, h + 1, 0, 0, 0, 0 );
surface_free( btnspr_over );

//create down sprite

btnspr_down = surface_create( w + 1, h + 1 );
surface_set_target( btnspr_down );
draw_set_color( c_dkgray );
draw_set_alpha( 1 );
draw_roundrect( 0, 0, w, h, 0 );
draw_set_color( c_black );
draw_set_alpha( 1 );
draw_roundrect( 0, 0, w, h, 1 );
surface_reset_target();
global.gmui_button_sprite_down = sprite_create_from_surface( btnspr_down, 0, 0, w + 1, h + 1, 0, 0, 0, 0 );
surface_free( btnspr_down );

#define GMUI_button_create

/*
argument0 = x
arugment1 = y
argument2 = button text
*/

var __a;
__a = instance_create( argument0, argument1, gmui_button );
__a.btn_text = argument2;

return __a;

#define GMUI_button_setsprites

/*
argument0 = button id
argument1 = sprite for up state
argument2 = sprite for over state
argument3 = sprite for down state
argument4 = sprite for hit mask
*/

if (argument1 != -1) {
    argument0.spr_up = argument1;
}
if (argument2 != -1) {
    argument0.spr_over = argument2;
}
if (argument3 != -1) {
    argument0.spr_down = argument3;
}
if (argument4 != -1) {
    argument0.spr_mask = argument4;
}

#define GMUI_button_pressed
return argument0.pressed;

#define GMUI_button_isdown
return argument0.isDown

#define GMUI_button_released
return argument0.released;

#define GMUI_checkbox_ini
var sur_uncheck, sur_check;
var w, h;

w = 16;
h = 16;

object_event_add( gmui_checkbox, ev_create, 0, "
gmui_checkbox_count += 1;
checkbox_id = gmui_button_count;
spr_uncheck = global.gmui_checkbox_sprite_uncheck;
spr_check = global.gmui_checkbox_sprite_check;
spr_mask = global.gmui_checkbox_sprite_mask;
checked = false;
title = '';
sprite_index = spr_uncheck;
mask_index = spr_mask;
");
object_event_add( gmui_checkbox, ev_step, 0, "
if (collision_point( mouse_x, mouse_y, global.gmui_checkbox, false, false ) ==  id) {
    if (mouse_check_button_pressed( mb_left )) {
        checked = !checked;
    }
}
if (checked == true) {
    sprite_index = spr_check;
}
else {
    sprite_index = spr_uncheck;
}
");
object_event_add( gmui_checkbox, ev_draw, 0, "
draw_sprite( sprite_index, -1, x, y );
draw_set_halign( fa_left );
draw_text( x+sprite_get_width(sprite_index)+4, y+sprite_get_height(sprite_index)/2, title );
");
       
sur_uncheck = surface_create( w+1, h+1 );
surface_set_target( sur_uncheck );
draw_set_alpha( .4 );
draw_set_color( c_white );
draw_rectangle( 0, 0, w, h, 0 );
draw_set_alpha( 1 );
draw_set_color( c_black );
draw_rectangle( 0, 0, w, h, 1 );
surface_reset_target();
global.gmui_checkbox_sprite_uncheck = sprite_create_from_surface( sur_uncheck, 0, 0, w+1, h+1, 0, 0, 0, 0 );
global.gmui_checkbox_sprite_mask = sprite_create_from_surface( sur_uncheck, 0, 0, w+1, h+1, 0, 0, 0, 0 );
surface_free( sur_uncheck );

sur_check = surface_create( w+1, h+1 );
surface_set_target( sur_check );
draw_set_alpha( .9 );
draw_circle_color( w/2, h/2, (w+h)/2, c_red, c_white, 0 );
draw_set_color( c_black );
draw_rectangle( 0, 0, w, h, 1 );
surface_reset_target();
global.gmui_checkbox_sprite_check = sprite_create_from_surface( sur_check, 0, 0, w+1, h+1, 0, 0, 0, 0 );
surface_free( sur_check );

#define GMUI_checkbox_create

/*
argument0 = x of checkbox
argument1 = y of checkbox
argument2 = title of checkbox
returns id of checkbox instance
*/

var __a;
__a = instance_create( argument0, argument1, global.gmui_checkbox );
__a.title = argument2;

return __a;

#define GMUI_checkbox_setsprites

/*
argument0 = button id
argument1 = sprite for checked state
argument2 = sprite for unchecked state
argument3 = sprite for hit mask
*/

if (argument1 != -1) {
    argument0.spr_check = argument1;
}
if (argument2 != -1) {
    argument0.spr_uncheck = argument2;
}
if (argument3 != -1) {
    argument0.spr_mask = argument3;
}

#define GMUI_checkbox_ischecked
return argument0.checked;

#define GMUI_radiobutton_ini
var sur_select, sur_unselect;
var w, h;

w = 16;
h = 16;

object_event_add( gmui_radiobutton, ev_create, 0, "
group = -1;
spr_selected = global.gmui_radiobutton_sprite_selected;
spr_unselected = global.gmui_radiobutton_sprite_unselected;
spr_mask = global.gmui_radiobutton_sprite_mask;
sprite_index = spr_unselected;
mask_index = spr_mask;
selected = false;
title = '';
");

object_event_add( gmui_radiobutton, ev_step, 0, "
if (collision_point( mouse_x, mouse_y, gmui_radiobutton, false, false ) == id) {
    if (mouse_check_button_pressed( mb_left )) {
        with (gmui_radiobutton) {
            if (group == other.group) {
                selected = false;
            }
        }
        selected = true;
    }
}
if (selected == true) {
    sprite_index = spr_selected;
}
else {
    sprite_index = spr_unselected;
}
");

object_event_add( gmui_radiobutton, ev_draw, 0, "
draw_sprite( sprite_index, -1, x, y );
draw_set_halign( fa_left );
draw_text( x+4+sprite_get_width( sprite_index ), y + sprite_get_height( sprite_index )/2, title );
");

sur_select = surface_create( w+1, h+1 );
surface_set_target( sur_select );
draw_set_alpha( .9 );
draw_circle_color( w/2, h/2, (w+h)/4, c_red, c_white, 0 );
draw_set_alpha( 1 );
draw_set_color( c_black );
draw_circle( w/2, h/2, (w+h)/4, 1 );
surface_reset_target();
global.gmui_radiobutton_sprite_selected = sprite_create_from_surface( sur_select, 0, 0, w+1, h+1, 0, 0, 0, 0 );

      
sur_unselect = surface_create( w+1, h+1 );
surface_set_target( sur_unselect );
draw_set_alpha( .4 );
draw_set_color( c_white );
draw_circle( w/2, h/2, (w+h)/4, 0 );
draw_set_alpha( 1 );
draw_set_color( c_black );
draw_circle( w/2, h/2, (w+h)/4, 1 );
surface_reset_target();
global.gmui_radiobutton_sprite_unselected = sprite_create_from_surface( sur_unselect, 0, 0, w+1, h+1, 0, 0, 0, 0 );
global.gmui_radiobutton_sprite_mask = sprite_create_from_surface( sur_unselect, 0, 0, w+1, h+1, 0, 0, 0, 0 );



#define GMUI_radiobutton_create

/*
argument0 = x of radio button
argument1 = y of radio button
argument2 = title of radio button
argument3 = radio button group (only one radiobutton per group can be selected at a time)
*/

var __a;

__a = instance_create( argument0, argument1, gmui_radiobutton );
__a.title = argument2;
__a.group = argument3;

return __a;

#define GMUI_radiobutton_setsprites

/*
argument0 = button id
argument1 = sprite for checked state
argument2 = sprite for unchecked state
argument3 = sprite for hit mask
*/

if (argument1 != -1) {
    argument0.spr_selected = argument1;
}
if (argument2 != -1) {
    argument0.spr_unselected = argument2;
}
if (argument3 != -1) {
    argument0.spr_mask = argument3;
}

#define GMUI_radiobutton_selected
//this script takes a radiobutton group and determines which instance of that group is selected, and returns it
with ( gmui_radiobutton ) {
    if (group == argument0 && selected == true) {
        return id;
    }
}

#define GMUI_radiobutton_isselected
return argument0.selected;

#define GMUI_textfield_ini


object_event_add( gmui_textfield, ev_create, 0, "
type = 'normal';
w = 200;
h = 200;
font = -1;
text = '';
sep = -1;
init = false;
text_sur = -1;
scroll_v = false;
v_x = 0;
v_y = 0;
v_w = w;
v_h = h;
box_y = 0;
box_h = 0;
dragging = false;
scrollto = false;
scrolly = y;
");

object_event_add( gmui_textfield, ev_step, 0, "
scroll_v = v_h < h; /* vertical-height */
if (scroll_v) {
    box_h = (v_h/h)*(v_h-32);
    box_y = ((v_x^2)/h) + 16;
    if (mouse_x < (x+w) && mouse_x > (x+w-16)) {
        if (mouse_y > (y+16) && mouse_y < (y+h-16)) {
            if (mouse_check_button_pressed(mb_left)) {
                if (mouse_x > x+w-16 && mouse_y > box_y &&
                    mouse_x < x+w && mouse_y < box_y+box_h) {
                    dragging = true;
                    scrollto = false;
                }
                else {
                    scrolly = mouse_y;
                    scrollto = true;
                    dragging = false;
                }
            }
        }
    }
    if (mouse_check_button_released(mb_left)) {
        scrollto = false;
        dragging = false;
    }
    if (scrollto) {
        scrolly = mouse_y;
        scrolly = min(y+h-16-box_h, scrolly);
        scrolly = max(y+16, scrolly);
        box_y -= (box_y-scrolly)/10;
    }
    if (dragging) {
        
}
");collision_rectangle(x1, y1, x2, y2, obj, prec, notme)

#define __textfield_setup

/*
argument0 = textfield's id
*/
//if (argument0.h > string_height_ext( argument0.text

