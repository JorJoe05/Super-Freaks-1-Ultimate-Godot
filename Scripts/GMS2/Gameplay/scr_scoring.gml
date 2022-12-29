enum game_timer_data
{
	pause = 0,
	ticks,
	seconds,
	minutes,
	hours,
}

/// @function scoring_init
function scoring_init()
{
	global.game_timer = array_create(5);
	global.score = 0;
}

/// @function game_timer_step
function game_timer_step()
{
	var _ticks = global.game_timer[game_timer_data.ticks];
	var _seconds = global.game_timer[game_timer_data.seconds];
	var _minutes = global.game_timer[game_timer_data.minutes];
	var _hours = global.game_timer[game_timer_data.hours];
	
	if (global.game_timer[game_timer_data.pause] == true || _hours == 99)
		exit;
	
	_ticks++;
	if (_ticks == 60)
	{
		_ticks = 0;
		_seconds++;
	}
	
	if (_seconds == 60)
	{
		_seconds = 0;
		_minutes++;
	}
	
	if (_minutes == 60)
	{
		_minutes = 0;
		_hours++;
	}
	
	global.game_timer[game_timer_data.ticks] = _ticks;
	global.game_timer[game_timer_data.seconds] = _seconds;
	global.game_timer[game_timer_data.minutes] = _minutes;
	global.game_timer[game_timer_data.hours] = _hours;
}

/// @function game_timer_pause
/// @param {Boolean} _pause = true
function game_timer_pause(_pause = true)
{
	global.game_timer[game_timer_data.pause] = _pause;
}

/// @function game_timer_reset
function game_timer_reset()
{
	global.game_timer[game_timer_data.ticks] = 0;
	global.game_timer[game_timer_data.seconds] = 0;
	global.game_timer[game_timer_data.minutes] = 0;
	global.game_timer[game_timer_data.hours] = 0;
}

/// @function game_timer_draw
/// @param _x
/// @param _y
function game_timer_draw(_x, _y)
{
	var _string = string_format(global.game_timer[game_timer_data.hours], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.minutes], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.seconds], 2, 0) + ":" + string_format(global.game_timer[game_timer_data.ticks], 2, 0);
	
	string_replace_all(_string, " ", "0");
	draw_text(_x, _y, _string);
	
	gml_pragma("forceinline");
}


/// @function yorbs_add
/// @param _amount = 1
function yorbs_add(_amount = 1)
{
	global.heart_meter += _amount;
	sfx_play_global(sfx_yorb);
	
	if (global.heart_meter > 99)
	{
		if (global.game_mode == game_modes.randomizer && global.hearts == 4)
			global.heart_meter = 99;
		else
		{
			global.hearts++;
			global.heart_meter = global.heart_meter mod 100;
			sfx_play_global(sfx_heart);
		}
	}
	
	gml_pragma("forceinline");
}
