function player_state_hang()
{
	var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
	var _move_h = 0;
	
	if (state_begin)
	{
		visible = true;
		camera.active = true;
		physics = player_physics_modifiers.normal;
		ball = false;
		lock_controls_horizontal = 0;
		lock_controls_vertical = 0;
		lock_friction = 0;
		lock_gravity = 0;
		collider_attach_clear();
		with (hitbox)
		{
			active = hitbox_active.active;
			hitbox_bitmask_set(true);
			hitbox_bitmask_to_check_set(true, true, true, true, true);
		}
		rubber_band_can_slingshot = false;
	}
	
	animate_speed = 0;
	hurt_timer_step();
	player_water_step();
	speed_h = 0;
	speed_v = 0;
		
	if (button_left == controls_action_states.hold) || (button_left == controls_action_states.press)
		_move_h -= 1;
	if (button_right == controls_action_states.hold) || (button_right == controls_action_states.press)
		_move_h += 1;
	
	switch (_move_h)
	{
		case -1:
			face = -1;
			break;
		case 0:
			break;
		case 1:
			face = 1;
			break;
	}
		
	if (!room_transition_active_get() && button_pause == controls_action_states.press)
		game_pause(player_number);
		
	if (button_jump == controls_action_states.press)
	{
		if (button_down == controls_action_states.press || button_down == controls_action_states.hold)
			speed_v = 6;
		else
		{
			jump_buffer = JUMP_BUFFER_MAX;
			speed_v = -speed_jump;
		}
		state_next_set(player_states.normal, 5);
		sfx_play_global(sfx_jump);
		ball = true;
		ground_on = false;
		coyote_time = 0;
		instance_attach = undefined;
	}
	jump_buffer = max(jump_buffer - 1, 0);
	
	if (is_undefined(instance_attach))
		state_next_set(player_states.normal, 5);
		
	switch sign(x - x_previous)
	{
		case -1:
			collision_left();
			break;
		case 0:
			collision_left();
			collision_right();
			break;
		case 1:
			collision_right();
			break;
	}
	
	switch sign(y - y_previous)
	{
		case -1:
			collision_up();
			break;
		case 0:
			collision_up();
			collision_down();
			break;
		case 1:
			collision_down();
			break;
	}
	
	_collision_left = collision_flag_get_left();
	_collision_up = collision_flag_get_up();
	_collision_right = collision_flag_get_right();
	_collision_down = collision_flag_get_down();
	
	if (_collision_left || _collision_right || _collision_up)
	{
		state_next_set(player_states.normal, 5);
		instance_attach = undefined;
	}
	else if (_collision_down)
	{
		state_next_set(player_states.normal, 5);
		instance_attach = undefined;
		ground_on = true;
		coyote_time = 0;
	}
	
	player_fall();
	
	#region Sprites
		sprite_index = player_animation_get(character_index, player_animations.hang);
	#endregion
}
