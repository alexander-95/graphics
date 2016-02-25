//Height=1080 Width=1920 Quality=11 Antialias=On Antialias_Threshold=0.0
//avconv -i concat:bb8b.avi\|bb8b.avi -c copy bb8b.avi
//avconv -i bb8%02d.png -c:v h264 -crf 1 bb8.avi


#include "colors.inc"
#include "glass.inc"
#include "golds.inc"
#include "metals.inc"
#include "stones.inc"
#include "woods.inc"
#include "textures"

#declare primary=pigment{White};
#declare secondary=pigment{Orange};

camera
{
	location<-14,20,-100>
	look_at<0,4,0>
	right 16/9*x
	up y
	rotate<0,frame_number,0>
}

light_source
{
	<-50,300,-100>
	color rgb<1,1,1>
}

//ground plane
plane
{
	y,0
	texture{pigment{checker White, Gray25} scale 15}
	translate<frame_number*5,0,0>
	finish{ reflection 1.0 ambient 0.1 diffuse 0.9 }
}

//extra fog effect
fog
{
	fog_type 2
	distance 500
	color rgb<1,2,2>
	fog_offset 0.0
	fog_alt 10
	turbulence 1.8
}

//crosshair pattern on bb8's body
#declare crosshair=union
{
	difference
	{	
		cylinder
		{
			<0,0,0>
			<0,100,0>
			10
			texture{primary}
		}
		cylinder
		{
			<0,-1,0>
			<0,101,0>
			8
			texture{primary}
		}
	}
	box
	{
		<-9,0,-1>
		<-5,100,1>
		texture{primary}
	}
	box
	{
		<5,0,-1>
		<9,100,1>
		texture{primary}
	}
	box
	{
		<-1,0,5>
		<1,100,9>
		texture{primary}
	}
	box
	{
		<-1,0,-9>
		<1,100,-5>
		texture{primary}
	}
}

//overall body pattern consists of a number of crosshair patterns
#declare body_pattern =intersection
{
	union
	{
		object
		{
			crosshair
			rotate<-90,0,0>
			translate<0,0,50>
		}
		object
		{
			crosshair
			rotate<0,0,0>
			translate<0,-50,0>
		}
		object
		{
			crosshair
			rotate<0,0,90>
			translate<50,0,0>
		}
	}
	sphere
	{
		<0,0,0>
		17
		texture{secondary}
	}
}

//white part of bb8's body
#declare bb8_shell=union
{
	difference
	{
		sphere
		{
			<0,0,0>
			16.9
			texture{primary}
		}
		union
		{
			box
			{
				<-20,-20,-0.25>
				<20,20,0.25>
				texture{primary}
				rotate<90,0,0>
			}
			box
			{
				<-20,-20,-0.25>
					<20,20,0.25>
				texture{primary}
				rotate<0,90,0>
			}
			box
			{
				<-20,-20,-0.25>
				<20,20,0.25>
				texture{primary}
				rotate<0,0,90>
			}
		}
	}	
	sphere
	{
		<0,0,0>
		16.8
		texture{pigment{Gray25}}
	}
	
	
}

//a single bolt on bb8's body for extra effect
#declare bolt=intersection
{
	cylinder
	{
		<0,-20,0>
		<0,20,0>
		0.5
		texture{Metal}
	}
	sphere
	{
		<0,0,0>
		17
		texture{Metal}
	}
}

//many bolts positioned on bb8's body
#declare bolts=union
{
	object{bolt rotate<100,45,0>}
	object{bolt rotate<80,45,0>}
	object{bolt rotate<100,-45,0>}
	object{bolt rotate<80,-45,0>}
	
	object{bolt rotate<100,45,0> rotate<90,0,0>}
	object{bolt rotate<80,45,0> rotate<90,0,0>}
	object{bolt rotate<100,-45,0> rotate<90,0,0>}
	object{bolt rotate<80,-45,0> rotate<90,0,0>}
	
	object{bolt rotate<100,45,0> rotate<0,0,90>}
	object{bolt rotate<80,45,0> rotate<0,0,90>}
	object{bolt rotate<100,-45,0> rotate<0,0,90>}
	object{bolt rotate<80,-45,0> rotate<0,0,90>}
}

//bb8's body all put together
#declare bb8_body=union
{
	object
	{
		bolts
	}
	object
	{
		bb8_shell
	}
	object
	{
		body_pattern
	}
}
//various stiped bands around bb8's head
#declare head_pattern=union
{
	intersection
	{
		sphere{<0,0,0> 10 texture{secondary}}
		cylinder{<0,0,0> <0,1,0> 10 texture{secondary}}
	}
	
	intersection
	{
		cylinder{<0,8.5,0> <0,9.5,0> 10 texture{primary}}
		sphere{<0,0,0> 10 texture{pigment{Gray25}}}
	}
	intersection
	{
		cylinder{<0,7,0><0,8,0>10 texture{secondary}}
		sphere{<0,0,0>10 texture{secondary}}
	}
}

//the white part of bb8's head
#declare head_shell=difference
{
	sphere
	{
		<0,0,0>
		9.9
		texture{primary}
		finish{ reflection 0.05 ambient 0.1 diffuse 0.9 }
	}
	box
	{
		<-10,-10,-10>
		<10,0,10>
		texture{primary}
	}
	translate<0,2,0>
}

//bb8's eye
#declare eye=union
{
	torus
	{
		2 0.2 texture{pigment{Gray25}}
		finish{ reflection 0.10 ambient 0.1 diffuse 0.9 }
	}
	sphere
	{
		<0,-1,0>
		2
		texture{pigment{Black}}
		finish{ reflection 0.10 ambient 0.1 diffuse 0.9 }
	}
}

//all the parts of bb8's head put together
#declare head=union
{
	//neck portion
	cone
	{
		<0,0,0>,8
		<0,2,0>,10
		translate<0,0,0>
		texture{pigment{Gray25}}
	}
	object
	{
		eye
		translate<0,10,0>
		rotate<-60,0,0>
		translate<0,2,0>
	}
	object
	{
		eye
		translate<0,10,0>
		rotate<-70,-30,0>
		translate<0,3,-3.8>
		scale 0.7
	}
	object
	{
		head_shell
	}
	object
	{
		head_pattern
		translate<0,2,0>
	}
	//antenna
	cylinder
	{
		<0,0,4>
		<0,15,4>
		0.2
		texture{primary}
	}
	//antenna
	cylinder
	{
		<0,0,6>
		<0,15,6>
		0.2
		texture{primary}
	}
	//antenna
	cylinder
	{
		<0,15,6>
		<0,16,6>
		0.25
		texture{primary}
	}
}

//object{bb8_body rotate<0,0,frame_number*10> translate<0,17,0>}
//object{head rotate<0,90,0> translate<0,32,0>}

object{bb8_body rotate<0,0,frame_number*10> translate<0,17,0> }
object{head rotate<0,45,0> translate<0,32,0>}

object{bb8_body rotate<0,0,frame_number*10> translate<50,17,0> scale 0.6}
object{head rotate<0,90,0> translate<0,15,0> rotate<0,0,-20> translate<50,17,0> scale 0.6}

//object{bb8_body rotate<0,0,frame_number*10> translate<-50,17,0> scale 0.9}
//object{head rotate<0,90,0> translate<0,15,0> rotate<0,0,-20> translate<-50,17,0> scale 0.9}
