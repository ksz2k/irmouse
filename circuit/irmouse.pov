//POVRay-File created by 3d41.ulp v1.05
///home/ksz/dyplom/avr/avr-usb/irmouse/schema/schema-tiny.brd
// 2/12/2007 22:53:30 

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 324;
#local cam_z = -116;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 38;
#local lgt1_pos_y = 57;
#local lgt1_pos_z = 26;
#local lgt1_intense = 0.773479;
#local lgt2_pos_x = -38;
#local lgt2_pos_y = 57;
#local lgt2_pos_z = 26;
#local lgt2_intense = 0.773479;
#local lgt3_pos_x = 38;
#local lgt3_pos_y = 57;
#local lgt3_pos_z = -18;
#local lgt3_intense = 0.773479;
#local lgt4_pos_x = -38;
#local lgt4_pos_y = 57;
#local lgt4_pos_z = -18;
#local lgt4_intense = 0.773479;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 101.270000;
#declare pcb_y_size = 50.790000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(772);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-50.635000,0,-25.395000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro SCHEMA_TINY(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<-0.470000,-0.630000><100.800000,-0.630000>
<100.800000,-0.630000><100.800000,50.160000>
<100.800000,50.160000><-0.470000,50.160000>
<-0.470000,50.160000><-0.470000,-0.630000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<96.697800,0.095000,19.380200><96.697800,-1.595000,19.380200>1.143000 texture{col_hls}}
cylinder{<96.697800,0.095000,31.419800><96.697800,-1.595000,31.419800>1.143000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_25MM_44MM("27p",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<69.850000,-0.000000,3.810000>}#end		//ceramic disc capacitator C1 27p C025-024X044
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_25MM_44MM("27p",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<49.530000,-0.000000,3.810000>}#end		//ceramic disc capacitator C2 27p C025-024X044
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_ELKO_2MM5_5MM("47u",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<43.180000,-0.000000,8.890000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C3 47u E2,5-5
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_CERAMIC_25MM_44MM("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<8.890000,-0.000000,16.510000>}#end		//ceramic disc capacitator C4 100n C025-024X044
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_CERAMIC_25MM_44MM("100n",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.180000,-0.000000,16.510000>}#end		//ceramic disc capacitator C5 100n C025-024X044
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_ELKO_2MM5_5MM("47u",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<8.890000,-0.000000,8.890000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C6 47u E2,5-5
#ifndef(pack_CODE_MATCH) #declare global_pack_CODE_MATCH=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,5.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<2.540000,-0.000000,12.700000>}#end		//Diskrete 5MM LED CODE-MATCH  LED5MM
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP20("AT90S2313P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<26.670000,-0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP20 IC1 AT90S2313P DIL20
#ifndef(pack_IC1) object{SOCKET_DIP20()rotate<0,-0.000000,0> rotate<0,0,0> translate<26.670000,-0.000000,15.240000>}#end					//IC-Sockel 20Pin IC1 AT90S2313P
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP20("AT90S2313P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<60.960000,-0.000000,15.240000>translate<0,3.000000,0> }#end		//DIP20 IC2 AT90S2313P DIL20
#ifndef(pack_IC2) object{SOCKET_DIP20()rotate<0,-0.000000,0> rotate<0,0,0> translate<60.960000,-0.000000,15.240000>}#end					//IC-Sockel 20Pin IC2 AT90S2313P
#ifndef(pack_IR_DATA) #declare global_pack_IR_DATA=yes; object {DIODE_DIS_LED_5MM(Yellow,0.500000,5.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<2.540000,-0.000000,21.590000>}#end		//Diskrete 5MM LED IR-DATA  LED5MM
#ifndef(pack_ISP1) #declare global_pack_ISP1=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<36.830000,-0.000000,35.560000>}#end		//Shrouded Header 10Pin ISP1  ML10
#ifndef(pack_ISP2) #declare global_pack_ISP2=yes; object {CON_DIS_WS10G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<66.040000,-0.000000,35.560000>}#end		//Shrouded Header 10Pin ISP2  ML10
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {PH_2X1J(2,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.050000,-0.000000,40.640000>}#end		//Jumper 2,54mm Grid 2Pin 1Row (jumper.lib) JP1  JP1
#ifndef(pack_POWER) #declare global_pack_POWER=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,5.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<2.540000,-0.000000,30.480000>}#end		//Diskrete 5MM LED POWER  LED5MM
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {SPC_XTAL_5MM("12MHz",12,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<59.690000,-0.000000,5.080000>}#end		//Quarz 4,9MM Q1 12MHz HC49/S
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<83.820000,-0.000000,20.320000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 2k2 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<83.820000,-0.000000,24.130000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 68R 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{Blue}finish{phong 0.2}},texture{pigment{Gray45}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<83.820000,-0.000000,5.080000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 68R 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<17.780000,-0.000000,31.750000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 330R 0207/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<20.320000,-0.000000,5.080000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R5 10k 0207/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_075MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<17.780000,-0.000000,27.940000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R6 330R 0207/7
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_075MM(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<17.780000,-0.000000,24.130000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R7 330R 0207/7
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<31.750000,-0.000000,5.080000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R8 10k 0207/7
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<69.850000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<69.850000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<49.530000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<49.530000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<43.180000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<8.890000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<43.180000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<8.890000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<8.890000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_CODE_MATCH) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_CODE_MATCH) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<91.440000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<81.280000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<91.440000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.100000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<35.560000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.850000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.390000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.390000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.850000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IR_DATA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_IR_DATA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<31.750000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<31.750000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<34.290000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<34.290000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<36.830000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<36.830000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.370000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.370000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<41.910000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<41.910000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<60.960000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<60.960000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<63.500000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<63.500000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<66.040000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<66.040000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<68.580000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<68.580000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<71.120000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_ISP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<71.120000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<19.050000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<2.540000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<57.277000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<62.103000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<80.010000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<87.630000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<80.010000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<87.630000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<80.010000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<87.630000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.970000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<21.590000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<24.130000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.970000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<21.590000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<13.970000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<21.590000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<27.940000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<2.540000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<2.540000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<2.540000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,24.150000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<91.998800,0,24.150000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<93.980000,0,26.650000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.302000,2.286000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<96.697800,0,31.419800> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(3.302000,2.286000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<96.697800,0,19.380200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<91.998800,0,26.650000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,15.240000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<1.270000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,29.210000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<1.270000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,15.240000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<1.270000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,20.320000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<1.270000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,20.320000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,90.000000,0> translate<2.540000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,29.210000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<1.270000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<2.540000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.270000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,12.700000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<1.270000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,12.700000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<2.540000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,43.180000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<2.540000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,45.720000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<2.540000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,10.160000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,0.000000,0> translate<3.810000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,10.160000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,90.000000,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,27.940000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<2.540000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<7.620000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,17.780000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<3.810000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,36.830000>}
box{<0,0,-0.254000><8.980256,0.035000,0.254000> rotate<0,44.997030,0> translate<3.810000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<3.810000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,39.370000>}
box{<0,0,-0.254000><8.980256,0.035000,0.254000> rotate<0,44.997030,0> translate<3.810000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,6.350000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,90.000000,0> translate<11.430000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,7.620000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<8.890000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,10.160000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<8.890000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,10.160000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,-90.000000,0> translate<11.430000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,15.240000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<8.890000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,7.620000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<11.430000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,16.510000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,90.000000,0> translate<12.700000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,19.050000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<8.890000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,24.130000>}
box{<0,0,-0.254000><14.368410,0.035000,0.254000> rotate<0,-44.997030,0> translate<2.540000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<13.970000,-1.535000,24.130000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<12.700000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<13.970000,-1.535000,27.940000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<7.620000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<13.970000,-1.535000,31.750000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<2.540000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,3.810000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,44.997030,0> translate<11.430000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,11.430000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,90.000000,0> translate<15.240000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,13.970000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<15.240000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,19.050000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<12.700000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<12.700000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,19.050000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<12.700000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,5.080000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<15.240000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,13.970000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,90.000000,0> translate<16.510000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,15.240000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<15.240000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,19.050000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<15.240000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,36.830000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<10.160000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,36.830000>}
box{<0,0,-0.254000><17.780000,0.035000,0.254000> rotate<0,90.000000,0> translate<16.510000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<17.780000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,35.560000>}
box{<0,0,-0.254000><16.510000,0.035000,0.254000> rotate<0,90.000000,0> translate<17.780000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.050000,-1.535000,6.350000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<16.510000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.050000,-1.535000,39.370000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<10.160000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,7.620000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<17.780000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,11.430000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<20.320000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,34.290000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<20.320000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.050000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,6.350000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<19.050000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,8.890000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<20.320000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,24.130000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<21.590000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,2.540000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<11.430000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.240000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,3.810000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<15.240000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,26.670000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<20.320000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,26.670000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<22.860000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,3.810000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<21.590000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,3.810000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<22.860000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,5.080000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<22.860000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,31.750000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.590000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<25.400000,-1.535000,6.350000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<24.130000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<25.400000,-1.535000,27.940000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.590000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.210000,-1.535000,16.510000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.590000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.210000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<30.480000,-1.535000,17.780000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<29.210000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<30.480000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<30.480000,-1.535000,19.050000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<30.480000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<25.400000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,6.350000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<25.400000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,34.290000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<20.320000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,36.830000>}
box{<0,0,-0.254000><15.240000,0.035000,0.254000> rotate<0,0.000000,0> translate<16.510000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.050000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,39.370000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,0.000000,0> translate<19.050000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,5.080000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<31.750000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,19.050000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<33.020000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<25.400000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,20.320000>}
box{<0,0,-0.254000><10.776307,0.035000,0.254000> rotate<0,44.997030,0> translate<25.400000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,38.100000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<31.750000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.290000,-1.535000,36.830000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<33.020000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,5.080000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<33.020000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<20.320000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,7.620000>}
box{<0,0,-0.254000><15.240000,0.035000,0.254000> rotate<0,0.000000,0> translate<20.320000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,8.890000>}
box{<0,0,-0.254000><13.970000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.590000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,19.050000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<24.130000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,20.320000>}
box{<0,0,-0.254000><16.164461,0.035000,0.254000> rotate<0,44.997030,0> translate<24.130000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,33.020000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,35.560000>}
box{<0,0,-0.254000><17.780000,0.035000,0.254000> rotate<0,0.000000,0> translate<17.780000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,6.350000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<35.560000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,7.620000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<35.560000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,8.890000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,-90.000000,0> translate<36.830000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,13.970000>}
box{<0,0,-0.254000><20.320000,0.035000,0.254000> rotate<0,0.000000,0> translate<16.510000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.290000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<34.290000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,11.430000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<38.100000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,13.970000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<36.830000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.510000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,15.240000>}
box{<0,0,-0.254000><21.590000,0.035000,0.254000> rotate<0,0.000000,0> translate<16.510000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,33.020000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<35.560000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,35.560000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-1.535000,8.890000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<36.830000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-1.535000,34.290000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<36.830000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,7.620000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,0.000000,0> translate<36.830000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,15.240000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,17.780000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,35.560000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<38.100000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,35.560000>}
box{<0,0,-0.254000><17.780000,0.035000,0.254000> rotate<0,90.000000,0> translate<40.640000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,8.890000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<40.640000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,17.780000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<39.370000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,10.160000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<40.640000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,15.240000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<40.640000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,17.780000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<41.910000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.450000,-1.535000,19.050000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<43.180000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.260000,-1.535000,1.270000>}
box{<0,0,-0.254000><40.640000,0.035000,0.254000> rotate<0,0.000000,0> translate<7.620000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.260000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,2.540000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<48.260000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,17.780000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<49.530000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.450000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,19.050000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<44.450000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,26.670000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<49.530000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,1.270000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<49.530000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,8.890000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<41.910000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,16.510000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<49.530000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,6.350000>}
box{<0,0,-0.254000><15.240000,0.035000,0.254000> rotate<0,0.000000,0> translate<36.830000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,7.620000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<43.180000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<50.800000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,11.430000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<52.070000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,8.890000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<52.070000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,8.890000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,-90.000000,0> translate<53.340000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,15.240000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,0.000000,0> translate<43.180000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,15.240000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<53.340000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<52.070000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,8.890000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<52.070000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,11.430000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<54.610000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,30.480000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,90.000000,0> translate<54.610000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,5.080000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<49.530000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,11.430000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,90.000000,0> translate<57.150000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,31.750000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,90.000000,0> translate<57.150000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.277000,-1.535000,5.080000>}
box{<0,0,-0.254000><0.127000,0.035000,0.254000> rotate<0,0.000000,0> translate<57.150000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,2.540000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<49.530000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,13.970000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<53.340000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,13.970000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,90.000000,0> translate<58.420000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,31.750000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<57.150000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,11.430000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<59.690000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,35.560000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<54.610000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.530000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,36.830000>}
box{<0,0,-0.254000><14.368410,0.035000,0.254000> rotate<0,-44.997030,0> translate<49.530000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-1.535000,34.290000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<58.420000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-1.535000,36.830000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<59.690000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.230000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.230000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<62.230000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.230000,-1.535000,38.100000>}
box{<0,0,-0.254000><29.210000,0.035000,0.254000> rotate<0,0.000000,0> translate<33.020000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,16.510000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,0.000000,0> translate<50.800000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,21.590000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,90.000000,0> translate<63.500000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.230000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,36.830000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<62.230000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,5.080000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,44.997030,0> translate<59.690000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.103000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,5.080000>}
box{<0,0,-0.254000><2.667000,0.035000,0.254000> rotate<0,0.000000,0> translate<62.103000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,12.700000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<64.770000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<62.230000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<66.040000,-1.535000,6.350000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,44.997030,0> translate<62.230000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<66.040000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<63.500000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,-1.535000,12.700000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<67.310000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,16.510000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<64.770000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,24.130000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<68.580000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.500000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,26.670000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<63.500000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<66.040000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<66.040000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.420000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.850000,-1.535000,2.540000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<58.420000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.770000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.850000,-1.535000,5.080000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<64.770000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.850000,-1.535000,35.560000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,0.000000,0> translate<59.690000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,-1.535000,16.510000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<67.310000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.850000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,-1.535000,34.290000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<69.850000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,-1.535000,36.830000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<68.580000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,-1.535000,11.430000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<72.390000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,16.510000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<71.120000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<66.040000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<78.740000,-1.535000,6.350000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,0.000000,0> translate<66.040000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<78.740000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.010000,-1.535000,5.080000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<78.740000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.010000,-1.535000,20.320000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<76.200000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.010000,-1.535000,24.130000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<68.580000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.850000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,2.540000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,0.000000,0> translate<69.850000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,10.160000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<72.390000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,10.160000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,90.000000,0> translate<81.280000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.280000,-1.535000,15.240000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,90.000000,0> translate<81.280000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.800000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.360000,-1.535000,1.270000>}
box{<0,0,-0.254000><35.560000,0.035000,0.254000> rotate<0,0.000000,0> translate<50.800000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<87.630000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<87.630000,-1.535000,24.130000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,90.000000,0> translate<87.630000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<87.630000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.170000,-1.535000,20.320000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<87.630000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.170000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.170000,-1.535000,20.320000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,90.000000,0> translate<90.170000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.170000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,15.240000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<90.170000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<87.630000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,24.130000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,0.000000,0> translate<87.630000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,26.670000>}
box{<0,0,-0.254000><22.860000,0.035000,0.254000> rotate<0,0.000000,0> translate<68.580000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.998800,-1.535000,24.150000>}
box{<0,0,-0.254000><0.559158,0.035000,0.254000> rotate<0,-2.049662,0> translate<91.440000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.998800,-1.535000,26.650000>}
box{<0,0,-0.254000><0.559158,0.035000,0.254000> rotate<0,2.049662,0> translate<91.440000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<87.630000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.710000,-1.535000,10.160000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<87.630000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.710000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<91.440000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.710000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,10.160000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<92.710000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,24.150000>}
box{<0,0,-0.254000><13.990000,0.035000,0.254000> rotate<0,90.000000,0> translate<93.980000,-1.535000,24.150000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,26.650000>}
box{<0,0,-0.254000><0.020000,0.035000,0.254000> rotate<0,-90.000000,0> translate<93.980000,-1.535000,26.650000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,36.830000>}
box{<0,0,-0.254000><22.860000,0.035000,0.254000> rotate<0,0.000000,0> translate<71.120000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,36.830000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,90.000000,0> translate<93.980000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.360000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,13.970000>}
box{<0,0,-0.254000><17.960512,0.035000,0.254000> rotate<0,-44.997030,0> translate<86.360000,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,26.670000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<93.980000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,26.670000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,90.000000,0> translate<99.060000,-1.535000,26.670000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
texture{col_pol}
}
#end
union{
cylinder{<69.850000,0.038000,5.080000><69.850000,-1.538000,5.080000>0.406400}
cylinder{<69.850000,0.038000,2.540000><69.850000,-1.538000,2.540000>0.406400}
cylinder{<49.530000,0.038000,5.080000><49.530000,-1.538000,5.080000>0.406400}
cylinder{<49.530000,0.038000,2.540000><49.530000,-1.538000,2.540000>0.406400}
cylinder{<43.180000,0.038000,10.160000><43.180000,-1.538000,10.160000>0.406400}
cylinder{<43.180000,0.038000,7.620000><43.180000,-1.538000,7.620000>0.406400}
cylinder{<8.890000,0.038000,17.780000><8.890000,-1.538000,17.780000>0.406400}
cylinder{<8.890000,0.038000,15.240000><8.890000,-1.538000,15.240000>0.406400}
cylinder{<43.180000,0.038000,15.240000><43.180000,-1.538000,15.240000>0.406400}
cylinder{<43.180000,0.038000,17.780000><43.180000,-1.538000,17.780000>0.406400}
cylinder{<8.890000,0.038000,7.620000><8.890000,-1.538000,7.620000>0.406400}
cylinder{<8.890000,0.038000,10.160000><8.890000,-1.538000,10.160000>0.406400}
cylinder{<2.540000,0.038000,13.970000><2.540000,-1.538000,13.970000>0.406400}
cylinder{<2.540000,0.038000,11.430000><2.540000,-1.538000,11.430000>0.406400}
cylinder{<81.280000,0.038000,15.240000><81.280000,-1.538000,15.240000>0.508000}
cylinder{<91.440000,0.038000,15.240000><91.440000,-1.538000,15.240000>0.508000}
cylinder{<81.280000,0.038000,10.160000><81.280000,-1.538000,10.160000>0.508000}
cylinder{<91.440000,0.038000,10.160000><91.440000,-1.538000,10.160000>0.508000}
cylinder{<15.240000,0.038000,11.430000><15.240000,-1.538000,11.430000>0.406400}
cylinder{<17.780000,0.038000,11.430000><17.780000,-1.538000,11.430000>0.406400}
cylinder{<20.320000,0.038000,11.430000><20.320000,-1.538000,11.430000>0.406400}
cylinder{<22.860000,0.038000,11.430000><22.860000,-1.538000,11.430000>0.406400}
cylinder{<25.400000,0.038000,11.430000><25.400000,-1.538000,11.430000>0.406400}
cylinder{<27.940000,0.038000,11.430000><27.940000,-1.538000,11.430000>0.406400}
cylinder{<30.480000,0.038000,11.430000><30.480000,-1.538000,11.430000>0.406400}
cylinder{<33.020000,0.038000,11.430000><33.020000,-1.538000,11.430000>0.406400}
cylinder{<35.560000,0.038000,11.430000><35.560000,-1.538000,11.430000>0.406400}
cylinder{<38.100000,0.038000,11.430000><38.100000,-1.538000,11.430000>0.406400}
cylinder{<38.100000,0.038000,19.050000><38.100000,-1.538000,19.050000>0.406400}
cylinder{<35.560000,0.038000,19.050000><35.560000,-1.538000,19.050000>0.406400}
cylinder{<33.020000,0.038000,19.050000><33.020000,-1.538000,19.050000>0.406400}
cylinder{<30.480000,0.038000,19.050000><30.480000,-1.538000,19.050000>0.406400}
cylinder{<27.940000,0.038000,19.050000><27.940000,-1.538000,19.050000>0.406400}
cylinder{<25.400000,0.038000,19.050000><25.400000,-1.538000,19.050000>0.406400}
cylinder{<22.860000,0.038000,19.050000><22.860000,-1.538000,19.050000>0.406400}
cylinder{<20.320000,0.038000,19.050000><20.320000,-1.538000,19.050000>0.406400}
cylinder{<17.780000,0.038000,19.050000><17.780000,-1.538000,19.050000>0.406400}
cylinder{<15.240000,0.038000,19.050000><15.240000,-1.538000,19.050000>0.406400}
cylinder{<49.530000,0.038000,11.430000><49.530000,-1.538000,11.430000>0.406400}
cylinder{<52.070000,0.038000,11.430000><52.070000,-1.538000,11.430000>0.406400}
cylinder{<54.610000,0.038000,11.430000><54.610000,-1.538000,11.430000>0.406400}
cylinder{<57.150000,0.038000,11.430000><57.150000,-1.538000,11.430000>0.406400}
cylinder{<59.690000,0.038000,11.430000><59.690000,-1.538000,11.430000>0.406400}
cylinder{<62.230000,0.038000,11.430000><62.230000,-1.538000,11.430000>0.406400}
cylinder{<64.770000,0.038000,11.430000><64.770000,-1.538000,11.430000>0.406400}
cylinder{<67.310000,0.038000,11.430000><67.310000,-1.538000,11.430000>0.406400}
cylinder{<69.850000,0.038000,11.430000><69.850000,-1.538000,11.430000>0.406400}
cylinder{<72.390000,0.038000,11.430000><72.390000,-1.538000,11.430000>0.406400}
cylinder{<72.390000,0.038000,19.050000><72.390000,-1.538000,19.050000>0.406400}
cylinder{<69.850000,0.038000,19.050000><69.850000,-1.538000,19.050000>0.406400}
cylinder{<67.310000,0.038000,19.050000><67.310000,-1.538000,19.050000>0.406400}
cylinder{<64.770000,0.038000,19.050000><64.770000,-1.538000,19.050000>0.406400}
cylinder{<62.230000,0.038000,19.050000><62.230000,-1.538000,19.050000>0.406400}
cylinder{<59.690000,0.038000,19.050000><59.690000,-1.538000,19.050000>0.406400}
cylinder{<57.150000,0.038000,19.050000><57.150000,-1.538000,19.050000>0.406400}
cylinder{<54.610000,0.038000,19.050000><54.610000,-1.538000,19.050000>0.406400}
cylinder{<52.070000,0.038000,19.050000><52.070000,-1.538000,19.050000>0.406400}
cylinder{<49.530000,0.038000,19.050000><49.530000,-1.538000,19.050000>0.406400}
cylinder{<2.540000,0.038000,22.860000><2.540000,-1.538000,22.860000>0.406400}
cylinder{<2.540000,0.038000,20.320000><2.540000,-1.538000,20.320000>0.406400}
cylinder{<31.750000,0.038000,34.290000><31.750000,-1.538000,34.290000>0.457200}
cylinder{<31.750000,0.038000,36.830000><31.750000,-1.538000,36.830000>0.457200}
cylinder{<34.290000,0.038000,34.290000><34.290000,-1.538000,34.290000>0.457200}
cylinder{<34.290000,0.038000,36.830000><34.290000,-1.538000,36.830000>0.457200}
cylinder{<36.830000,0.038000,34.290000><36.830000,-1.538000,34.290000>0.457200}
cylinder{<36.830000,0.038000,36.830000><36.830000,-1.538000,36.830000>0.457200}
cylinder{<39.370000,0.038000,34.290000><39.370000,-1.538000,34.290000>0.457200}
cylinder{<39.370000,0.038000,36.830000><39.370000,-1.538000,36.830000>0.457200}
cylinder{<41.910000,0.038000,34.290000><41.910000,-1.538000,34.290000>0.457200}
cylinder{<41.910000,0.038000,36.830000><41.910000,-1.538000,36.830000>0.457200}
cylinder{<60.960000,0.038000,34.290000><60.960000,-1.538000,34.290000>0.457200}
cylinder{<60.960000,0.038000,36.830000><60.960000,-1.538000,36.830000>0.457200}
cylinder{<63.500000,0.038000,34.290000><63.500000,-1.538000,34.290000>0.457200}
cylinder{<63.500000,0.038000,36.830000><63.500000,-1.538000,36.830000>0.457200}
cylinder{<66.040000,0.038000,34.290000><66.040000,-1.538000,34.290000>0.457200}
cylinder{<66.040000,0.038000,36.830000><66.040000,-1.538000,36.830000>0.457200}
cylinder{<68.580000,0.038000,34.290000><68.580000,-1.538000,34.290000>0.457200}
cylinder{<68.580000,0.038000,36.830000><68.580000,-1.538000,36.830000>0.457200}
cylinder{<71.120000,0.038000,34.290000><71.120000,-1.538000,34.290000>0.457200}
cylinder{<71.120000,0.038000,36.830000><71.120000,-1.538000,36.830000>0.457200}
cylinder{<19.050000,0.038000,41.910000><19.050000,-1.538000,41.910000>0.457200}
cylinder{<19.050000,0.038000,39.370000><19.050000,-1.538000,39.370000>0.457200}
cylinder{<2.540000,0.038000,31.750000><2.540000,-1.538000,31.750000>0.406400}
cylinder{<2.540000,0.038000,29.210000><2.540000,-1.538000,29.210000>0.406400}
cylinder{<57.277000,0.038000,5.080000><57.277000,-1.538000,5.080000>0.406400}
cylinder{<62.103000,0.038000,5.080000><62.103000,-1.538000,5.080000>0.406400}
cylinder{<80.010000,0.038000,20.320000><80.010000,-1.538000,20.320000>0.406400}
cylinder{<87.630000,0.038000,20.320000><87.630000,-1.538000,20.320000>0.406400}
cylinder{<80.010000,0.038000,24.130000><80.010000,-1.538000,24.130000>0.406400}
cylinder{<87.630000,0.038000,24.130000><87.630000,-1.538000,24.130000>0.406400}
cylinder{<80.010000,0.038000,5.080000><80.010000,-1.538000,5.080000>0.406400}
cylinder{<87.630000,0.038000,5.080000><87.630000,-1.538000,5.080000>0.406400}
cylinder{<13.970000,0.038000,31.750000><13.970000,-1.538000,31.750000>0.406400}
cylinder{<21.590000,0.038000,31.750000><21.590000,-1.538000,31.750000>0.406400}
cylinder{<16.510000,0.038000,5.080000><16.510000,-1.538000,5.080000>0.406400}
cylinder{<24.130000,0.038000,5.080000><24.130000,-1.538000,5.080000>0.406400}
cylinder{<13.970000,0.038000,27.940000><13.970000,-1.538000,27.940000>0.406400}
cylinder{<21.590000,0.038000,27.940000><21.590000,-1.538000,27.940000>0.406400}
cylinder{<13.970000,0.038000,24.130000><13.970000,-1.538000,24.130000>0.406400}
cylinder{<21.590000,0.038000,24.130000><21.590000,-1.538000,24.130000>0.406400}
cylinder{<27.940000,0.038000,5.080000><27.940000,-1.538000,5.080000>0.406400}
cylinder{<35.560000,0.038000,5.080000><35.560000,-1.538000,5.080000>0.406400}
cylinder{<2.540000,0.038000,45.720000><2.540000,-1.538000,45.720000>0.406400}
cylinder{<2.540000,0.038000,38.100000><2.540000,-1.538000,38.100000>0.406400}
cylinder{<2.540000,0.038000,43.180000><2.540000,-1.538000,43.180000>0.406400}
cylinder{<93.980000,0.038000,24.150000><93.980000,-1.538000,24.150000>0.457200}
cylinder{<91.998800,0.038000,24.150000><91.998800,-1.538000,24.150000>0.457200}
cylinder{<93.980000,0.038000,26.650000><93.980000,-1.538000,26.650000>0.457200}
cylinder{<91.998800,0.038000,26.650000><91.998800,-1.538000,26.650000>0.457200}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,5.969000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.215000,0.000000,5.969000> }
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<70.485000,0.000000,5.461000>}
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<69.215000,0.000000,5.461000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.993000,0.000000,5.461000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<70.993000,0.000000,5.461000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,1.651000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.215000,0.000000,1.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.707000,0.000000,5.461000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.707000,0.000000,5.461000> }
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<70.485000,0.000000,2.159000>}
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<69.215000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.612000,0.000000,4.114800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.088000,0.000000,4.114800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<69.088000,0.000000,4.114800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<70.612000,0.000000,3.479800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<69.088000,0.000000,3.479800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<69.088000,0.000000,3.479800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,3.479800>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,90.000000,0> translate<69.850000,0.000000,3.479800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,4.114800>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.850000,0.000000,4.114800> }
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,5.969000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.895000,0.000000,5.969000> }
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<50.165000,0.000000,5.461000>}
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<48.895000,0.000000,5.461000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.673000,0.000000,5.461000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.673000,0.000000,5.461000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,1.651000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.895000,0.000000,1.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,5.461000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,5.461000> }
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<50.165000,0.000000,2.159000>}
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<48.895000,0.000000,2.159000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<50.292000,0.000000,4.114800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<48.768000,0.000000,4.114800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<48.768000,0.000000,4.114800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<50.292000,0.000000,3.479800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<48.768000,0.000000,3.479800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<48.768000,0.000000,3.479800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,3.479800>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,90.000000,0> translate<49.530000,0.000000,3.479800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,4.114800>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.530000,0.000000,4.114800> }
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.287000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.196000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.287000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.196000,0.000000,10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.033000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,10.287000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,9.652000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,9.652000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,9.144000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.910000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,9.144000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,9.652000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,9.652000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.180000,0.000000,9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,7.239000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,7.239000> }
difference{
cylinder{<43.180000,0,8.890000><43.180000,0.036000,8.890000>2.616200 translate<0,0.000000,0>}
cylinder{<43.180000,-0.1,8.890000><43.180000,0.135000,8.890000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-270.000000,0> translate<43.180000,0.000000,8.382000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,18.669000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,18.669000> }
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<9.525000,0.000000,18.161000>}
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<8.255000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.033000,0.000000,18.161000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.033000,0.000000,18.161000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,14.351000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,18.161000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.747000,0.000000,18.161000> }
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<9.525000,0.000000,14.859000>}
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<8.255000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.652000,0.000000,16.814800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.128000,0.000000,16.814800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.128000,0.000000,16.814800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<9.652000,0.000000,16.179800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<8.128000,0.000000,16.179800>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<8.128000,0.000000,16.179800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,16.179800>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,16.179800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,16.814800>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.890000,0.000000,16.814800> }
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,14.351000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,14.351000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,14.351000> }
object{ARC(0.508000,0.152400,180.000000,270.000000,0.036000) translate<42.545000,0.000000,14.859000>}
object{ARC(0.508000,0.152400,270.000000,360.000000,0.036000) translate<43.815000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.037000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.037000,0.000000,14.859000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.037000,0.000000,14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,18.669000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.323000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.323000,0.000000,14.859000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.323000,0.000000,14.859000> }
object{ARC(0.508000,0.152400,90.000000,180.000000,0.036000) translate<42.545000,0.000000,18.161000>}
object{ARC(0.508000,0.152400,0.000000,90.000000,0.036000) translate<43.815000,0.000000,18.161000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.418000,0.000000,16.205200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<43.942000,0.000000,16.205200>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<42.418000,0.000000,16.205200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<42.418000,0.000000,16.840200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<43.942000,0.000000,16.840200>}
box{<0,0,-0.152400><1.524000,0.036000,0.152400> rotate<0,0.000000,0> translate<42.418000,0.000000,16.840200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,16.840200>}
box{<0,0,-0.076200><0.939800,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,16.840200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,16.205200>}
box{<0,0,-0.076200><0.965200,0.036000,0.076200> rotate<0,90.000000,0> translate<43.180000,0.000000,16.205200> }
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.493000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.874000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.493000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.747000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,7.493000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.366000,0.000000,7.493000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.366000,0.000000,7.493000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.128000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,8.128000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,8.636000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.636000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.128000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,8.128000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,10.541000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,10.541000> }
difference{
cylinder{<8.890000,0,8.890000><8.890000,0.036000,8.890000>2.616200 translate<0,0.000000,0>}
cylinder{<8.890000,-0.1,8.890000><8.890000,0.135000,8.890000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<8.890000,0.000000,9.398000>}
//CODE-MATCH silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<0.635000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.445000,0.000000,10.160000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<0.635000,0.000000,10.160000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,12.700000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,12.700000>}
difference{
cylinder{<2.540000,0,12.700000><2.540000,0.036000,12.700000>2.616200 translate<0,0.000000,0>}
cylinder{<2.540000,-0.1,12.700000><2.540000,0.135000,12.700000>2.463800 translate<0,0.000000,0>}}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,16.764000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.185000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,13.716000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.185000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,16.764000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,13.716000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.185000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,16.764000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.535000,0.000000,16.764000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<81.280000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<82.550000,0.000000,15.240000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,0.000000,0> translate<81.280000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<91.440000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<90.170000,0.000000,15.240000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,0.000000,0> translate<90.170000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.344000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<85.344000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,15.240000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,14.605000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<85.344000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.875000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.360000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,14.605000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.106000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,15.240000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.360000,0.000000,15.240000> }
box{<-0.381000,0,-1.524000><0.381000,0.036000,1.524000> rotate<0,-180.000000,0> translate<88.519000,0.000000,15.240000>}
box{<-0.279400,0,-0.406400><0.279400,0.036000,0.406400> rotate<0,-180.000000,0> translate<82.905600,0.000000,15.240000>}
box{<-0.279400,0,-0.406400><0.279400,0.036000,0.406400> rotate<0,-180.000000,0> translate<89.814400,0.000000,15.240000>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,11.684000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.185000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,8.636000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.185000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.185000,0.000000,8.636000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.185000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.535000,0.000000,11.684000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<89.535000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<81.280000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<82.550000,0.000000,10.160000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,0.000000,0> translate<81.280000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<91.440000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.406400 translate<90.170000,0.000000,10.160000>}
box{<0,0,-0.406400><1.270000,0.036000,0.406400> rotate<0,0.000000,0> translate<90.170000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.344000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,32.003271,0> translate<85.344000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.836000,0.000000,10.160000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<84.836000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.344000,0.000000,9.525000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-32.003271,0> translate<85.344000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.795000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.360000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.106000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,9.525000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.106000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,10.160000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.360000,0.000000,10.160000> }
box{<-0.381000,0,-1.524000><0.381000,0.036000,1.524000> rotate<0,-180.000000,0> translate<88.519000,0.000000,10.160000>}
box{<-0.279400,0,-0.406400><0.279400,0.036000,0.406400> rotate<0,-180.000000,0> translate<82.905600,0.000000,10.160000>}
box{<-0.279400,0,-0.406400><0.279400,0.036000,0.406400> rotate<0,-180.000000,0> translate<89.814400,0.000000,10.160000>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,12.446000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.462000,0.000000,12.446000> }
object{ARC(0.635000,0.152400,270.000000,450.000000,0.036000) translate<13.462000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,18.034000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.878000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,12.446000>}
box{<0,0,-0.076200><26.416000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.462000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,15.875000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.462000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.462000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,18.034000>}
box{<0,0,-0.076200><26.416000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.462000,0.000000,18.034000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,12.446000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.752000,0.000000,12.446000> }
object{ARC(0.635000,0.152400,270.000000,450.000000,0.036000) translate<47.752000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,18.034000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.168000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,12.446000>}
box{<0,0,-0.076200><26.416000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.752000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,15.875000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.752000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,18.034000>}
box{<0,0,-0.076200><26.416000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.752000,0.000000,18.034000> }
//IR-DATA silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<0.635000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.445000,0.000000,19.050000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<0.635000,0.000000,19.050000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,21.590000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,21.590000>}
difference{
cylinder{<2.540000,0,21.590000><2.540000,0.036000,21.590000>2.616200 translate<0,0.000000,0>}
cylinder{<2.540000,-0.1,21.590000><2.540000,0.135000,21.590000>2.463800 translate<0,0.000000,0>}}
//ISP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,38.735000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.940000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,38.735000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,32.385000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.940000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.291000,0.000000,31.115000>}
box{<0,0,-0.076200><4.699000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.291000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,40.005000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.990000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,31.115000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.670000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,32.385000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,33.147000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,33.147000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.798000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,32.385000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.940000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.798000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,32.385000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.862000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.862000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,40.259000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.450000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.259000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.195000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.465000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
box{<0,0,-0.076200><6.985000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.195000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.940000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.940000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.210000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,40.005000>}
box{<0,0,-0.076200><6.985000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.989000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,31.115000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,31.115000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.878000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,32.385000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.402000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,32.385000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.878000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.989000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,31.623000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-53.126596,0> translate<38.989000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.291000,0.000000,31.115000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,53.126596,0> translate<41.910000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<39.878000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<38.862000,0.000000,32.131000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,0.000000,0> translate<38.862000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,31.115000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.862000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<41.402000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.974000,0.000000,32.131000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,0.000000,0> translate<41.402000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.974000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.974000,0.000000,38.989000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,90.000000,0> translate<45.974000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<45.974000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.686000,0.000000,38.989000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,0.000000,0> translate<27.686000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.686000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.686000,0.000000,32.131000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,-90.000000,0> translate<27.686000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<27.686000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<34.798000,0.000000,32.131000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,0.000000,0> translate<27.686000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,31.115000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.798000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.878000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.370000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.402000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,31.623000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.878000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,31.115000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,31.115000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.385000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,31.242000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,31.242000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.670000,0.000000,31.115000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.670000,0.000000,31.115000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<34.290000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<31.750000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<36.830000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<41.910000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<39.370000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<34.290000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<31.750000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<36.830000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<41.910000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<39.370000,0.000000,34.290000>}
//ISP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,38.735000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,38.735000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.930000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,32.385000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.150000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,31.115000>}
box{<0,0,-0.076200><4.699000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.501000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,40.005000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.200000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,31.115000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.880000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,32.385000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.612000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,33.147000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.008000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,33.147000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.008000,0.000000,33.147000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,32.385000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.008000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,33.147000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,32.385000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.072000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.072000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,40.259000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.930000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.660000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,40.259000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.660000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.930000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.930000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.675000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,40.005000>}
box{<0,0,-0.076200><6.985000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.675000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.405000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,40.259000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.150000,0.000000,40.259000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.150000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,40.259000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,40.005000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.420000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,40.005000>}
box{<0,0,-0.076200><6.985000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,31.115000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.072000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,31.115000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<64.008000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.088000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,32.385000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.072000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,32.131000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.612000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,32.385000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.088000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.199000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,31.623000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-53.126596,0> translate<68.199000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,31.115000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,53.126596,0> translate<71.120000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.612000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<69.088000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<68.072000,0.000000,32.131000>}
box{<0,0,-0.025400><1.016000,0.036000,0.025400> rotate<0,0.000000,0> translate<68.072000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,31.115000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.072000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<70.612000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.184000,0.000000,32.131000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,0.000000,0> translate<70.612000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.184000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.184000,0.000000,38.989000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,90.000000,0> translate<75.184000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<75.184000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.896000,0.000000,38.989000>}
box{<0,0,-0.025400><18.288000,0.036000,0.025400> rotate<0,0.000000,0> translate<56.896000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.896000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.896000,0.000000,32.131000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,-90.000000,0> translate<56.896000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<56.896000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<64.008000,0.000000,32.131000>}
box{<0,0,-0.025400><7.112000,0.036000,0.025400> rotate<0,0.000000,0> translate<56.896000,0.000000,32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,31.115000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.008000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.088000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,31.623000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.612000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.612000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,31.623000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.088000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.595000,0.000000,31.115000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.595000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.595000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.595000,0.000000,31.115000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.595000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.595000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,31.242000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.325000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,31.242000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.325000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.880000,0.000000,31.115000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.880000,0.000000,31.115000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<63.500000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<60.960000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<66.040000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<71.120000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<68.580000,0.000000,36.830000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<63.500000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<60.960000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<66.040000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<71.120000,0.000000,34.290000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<68.580000,0.000000,34.290000>}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.386000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<20.066000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.894000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.066000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,40.386000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.780000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,40.894000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<17.780000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,42.926000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,42.926000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.780000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,38.100000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<17.780000,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,40.386000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,38.100000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.034000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,38.100000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.066000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.386000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,42.926000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,42.926000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<20.066000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.066000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,43.180000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.034000,0.000000,43.180000> }
box{<-0.304800,0,-0.304800><0.304800,0.036000,0.304800> rotate<0,-180.000000,0> translate<19.050000,0.000000,39.370000>}
box{<-0.304800,0,-0.304800><0.304800,0.036000,0.304800> rotate<0,-180.000000,0> translate<19.050000,0.000000,41.910000>}
//POWER silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<0.635000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<4.445000,0.000000,27.940000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<0.635000,0.000000,27.940000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<2.540000,0.000000,30.480000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<2.540000,0.000000,30.480000>}
difference{
cylinder{<2.540000,0,30.480000><2.540000,0.036000,30.480000>2.616200 translate<0,0.000000,0>}
cylinder{<2.540000,-0.1,30.480000><2.540000,0.135000,30.480000>2.463800 translate<0,0.000000,0>}}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<56.642000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<62.738000,0.000000,2.921000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,0.000000,0> translate<56.642000,0.000000,2.921000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<56.642000,0.000000,7.239000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<62.738000,0.000000,7.239000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,0.000000,0> translate<56.642000,0.000000,7.239000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,3.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,3.429000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.642000,0.000000,3.429000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,6.731000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.642000,0.000000,6.731000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,5.842000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.436000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,4.318000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.944000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.944000,0.000000,4.318000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,4.318000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.436000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,4.318000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.436000,0.000000,5.842000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.436000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,5.080000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.325000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,4.318000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.325000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,5.080000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,4.318000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,4.318000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.325000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,5.080000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.325000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.420000,0.000000,5.080000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.420000,0.000000,5.080000> }
object{ARC(2.159000,0.406400,90.000000,270.000000,0.036000) translate<56.642000,0.000000,5.080000>}
object{ARC(2.159000,0.406400,270.000000,450.000000,0.036000) translate<62.738000,0.000000,5.080000>}
object{ARC(1.651000,0.152400,90.000000,270.000000,0.036000) translate<56.642000,0.000000,5.080000>}
object{ARC(1.651000,0.152400,270.000000,450.000000,0.036000) translate<62.738000,0.000000,5.080000>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.010000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.391000,0.000000,20.320000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<80.010000,0.000000,20.320000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<80.899000,0.000000,21.209000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<80.899000,0.000000,19.431000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<86.741000,0.000000,19.431000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<86.741000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,19.431000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,21.209000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.645000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,21.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,21.463000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,21.463000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,21.463000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<81.280000,0.000000,21.463000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,19.177000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,19.177000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<81.280000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,21.463000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<86.233000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,21.336000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,19.177000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<86.233000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,19.304000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,21.463000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,21.463000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,21.463000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,19.177000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,19.431000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,21.209000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.995000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.249000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.630000,0.000000,20.320000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<87.249000,0.000000,20.320000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<80.518000,0.000000,20.320000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<87.122000,0.000000,20.320000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.010000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.391000,0.000000,24.130000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<80.010000,0.000000,24.130000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<80.899000,0.000000,25.019000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<80.899000,0.000000,23.241000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<86.741000,0.000000,23.241000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<86.741000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,25.019000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.645000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,25.273000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,25.273000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<81.280000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,22.987000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,22.987000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<81.280000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,25.273000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<86.233000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,25.146000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,22.987000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<86.233000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,23.114000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,25.273000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,22.987000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,25.019000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.995000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.249000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.630000,0.000000,24.130000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<87.249000,0.000000,24.130000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<80.518000,0.000000,24.130000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<87.122000,0.000000,24.130000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.010000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<80.391000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<80.010000,0.000000,5.080000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<80.899000,0.000000,5.969000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<80.899000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<86.741000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<86.741000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.645000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<80.645000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<81.280000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<80.899000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<80.899000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.280000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<81.280000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<86.233000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,6.096000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<86.233000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.233000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,4.064000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.407000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.741000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.360000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<86.360000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<86.995000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<86.995000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.249000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<87.630000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<87.249000,0.000000,5.080000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<80.518000,0.000000,5.080000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<87.122000,0.000000,5.080000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<13.970000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.351000,0.000000,31.750000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<13.970000,0.000000,31.750000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<14.859000,0.000000,32.639000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<14.859000,0.000000,30.861000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<20.701000,0.000000,30.861000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<20.701000,0.000000,32.639000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,32.639000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,32.639000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,32.893000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,32.893000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,30.607000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,30.607000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,30.607000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,30.607000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,30.607000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,32.893000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.193000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,32.766000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,30.607000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<20.193000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,30.734000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,30.734000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,32.893000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,32.893000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,30.607000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,30.607000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,30.607000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,32.639000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,32.639000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.209000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,31.750000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<21.209000,0.000000,31.750000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<14.478000,0.000000,31.750000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<21.082000,0.000000,31.750000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<16.510000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<16.891000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<16.510000,0.000000,5.080000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.399000,0.000000,5.969000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.399000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<23.241000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<23.241000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.399000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.907000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.780000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.399000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.907000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.780000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.733000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.907000,0.000000,6.096000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.907000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.733000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.733000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.907000,0.000000,4.064000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.907000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.241000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.860000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.241000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.860000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<23.495000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<23.749000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<23.749000,0.000000,5.080000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<17.018000,0.000000,5.080000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<23.622000,0.000000,5.080000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<13.970000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.351000,0.000000,27.940000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<13.970000,0.000000,27.940000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<14.859000,0.000000,28.829000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<14.859000,0.000000,27.051000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<20.701000,0.000000,27.051000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<20.701000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,28.829000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,29.083000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,29.083000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,29.083000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,29.083000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,29.083000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,26.797000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,26.797000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,29.083000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.193000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,28.956000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,28.956000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,28.956000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,26.797000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<20.193000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,26.924000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,26.924000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,26.924000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,29.083000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,29.083000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,29.083000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,26.797000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,28.829000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.209000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,27.940000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<21.209000,0.000000,27.940000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<14.478000,0.000000,27.940000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<21.082000,0.000000,27.940000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<13.970000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.351000,0.000000,24.130000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<13.970000,0.000000,24.130000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<14.859000,0.000000,25.019000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<14.859000,0.000000,23.241000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<20.701000,0.000000,23.241000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<20.701000,0.000000,25.019000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,25.019000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<14.605000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,25.273000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,25.273000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,22.987000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,22.987000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,25.273000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.193000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,25.146000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,22.987000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<20.193000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,23.114000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,25.273000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,22.987000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,25.019000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,25.019000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.209000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,24.130000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<21.209000,0.000000,24.130000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<14.478000,0.000000,24.130000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<21.082000,0.000000,24.130000>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<27.940000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<28.321000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<27.940000,0.000000,5.080000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<28.829000,0.000000,5.969000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<28.829000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<34.671000,0.000000,4.191000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<34.671000,0.000000,5.969000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.575000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.829000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.337000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<29.210000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.829000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.337000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.210000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,6.223000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.163000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.337000,0.000000,6.096000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.337000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,3.937000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<34.163000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.337000,0.000000,4.064000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.337000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,6.223000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,6.223000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,3.937000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,5.969000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.925000,0.000000,5.969000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.560000,0.000000,5.080000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<35.179000,0.000000,5.080000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<28.448000,0.000000,5.080000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<35.052000,0.000000,5.080000>}
//U$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,44.490000>}
box{<0,0,-0.063500><2.500000,0.036000,0.063500> rotate<0,-90.000000,0> translate<4.445000,0.000000,44.490000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,44.490000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,39.490000>}
box{<0,0,-0.063500><5.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<4.445000,0.000000,39.490000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,39.490000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,36.990000>}
box{<0,0,-0.063500><2.500000,0.036000,0.063500> rotate<0,-90.000000,0> translate<4.445000,0.000000,36.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,36.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,36.990000>}
box{<0,0,-0.063500><4.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<0.445000,0.000000,36.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.445000,0.000000,46.990000>}
box{<0,0,-0.063500><4.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<0.445000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,44.490000>}
box{<0,0,-0.063500><2.500000,0.036000,0.063500> rotate<0,-90.000000,0> translate<0.445000,0.000000,44.490000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,44.490000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,39.490000>}
box{<0,0,-0.063500><5.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<0.445000,0.000000,39.490000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,39.490000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<0.445000,0.000000,36.990000>}
box{<0,0,-0.063500><2.500000,0.036000,0.063500> rotate<0,-90.000000,0> translate<0.445000,0.000000,36.990000> }
object{ARC(2.692600,0.127000,111.801409,248.198591,0.036000) translate<1.445000,0.000000,41.990000>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.743400,0.000000,19.385600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<90.743400,0.000000,31.399800>}
box{<0,0,-0.063500><12.014200,0.036000,0.063500> rotate<0,90.000000,0> translate<90.743400,0.000000,31.399800> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  SCHEMA_TINY(-50.165000,0,-24.765000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//D1	3V6	F126Z10
//D2	3V6	F126Z10
//U$1	TSOP1736	TSOP17XX
//X1	USB-B-H	USB-B-H
