#include <gb/gb.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>

//Sprite data
#include "LogoSprite.c"

//Variables
int logoX;
int logoY;
int speedX = 1;
int speedY = 1;

int main(){
	//Set the sprite
	set_sprite_data(0, 4, LogoSprite);
	set_sprite_tile(0, 0);
	SHOW_SPRITES;

	//Set a random number for the postiton of the sprite
	logoX = abs( rand()%(80-10) + 10);
	logoY = abs(rand()%(80-10) + 10);

	//Set the postiton to the sprite
	move_sprite(0, logoX, logoY);

	while(1){

		//Check when the sprite hit a the border of the screen and bounce
		if(logoX >= 160){
			speedX = -1;
			set_sprite_tile(0, 1);
		}else if(logoX-8 <= 0){
			speedX = 1;
			set_sprite_tile(0, 2);
		}

		if(logoY-8 >= 144){
			speedY = -1;
			set_sprite_tile(0, 0);
		}else if(logoY-16 <= 0){
			speedY = 1;
			set_sprite_tile(0, 3);
		}

		//Apply the movement to the postiton
		logoX = logoX + speedX;
		logoY = logoY + speedY;

		//A Delay to slow down the speed
		delay(25);

		//Set the new postiton to the sprite
		move_sprite(0, logoX, logoY);
	}
}