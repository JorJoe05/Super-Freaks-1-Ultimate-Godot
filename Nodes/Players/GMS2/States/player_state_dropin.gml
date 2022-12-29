function player_state_dropin()
{
	if (state_begin)
	{
		visible = false;
		camera.active = false;
		physics = player_physics_modifiers.normal;
		ball = false;
		hitbox.active = hitbox_active.inactive;
		rubber_band_can_slingshot = false;
		sfx_play_global(sfx_ding);
	}
	
	if (button_left == controls_action_states.press)
	{
		character_index++;
					
		if (character_index > 3)
			character_index = 0;
	}
	else if (button_right == controls_action_states.press)
	{
		character_index--;
					
		if (character_index < 0)
			character_index = 3;
	}
	else if (button_jump == controls_action_states.press)
	{
		state_next_set(player_states.bubble, 999999999);
		global.player_list[player_number][player_data.active] = true;
		global.player_list[player_number][player_data.character_index] = character_index;
		x = view_x1_get();
		y = view_y1_get();
		x_start_frame = x;
		y_start_frame = y;
	}
}
