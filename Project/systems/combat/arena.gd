extends Node3D

enum {PLAYER_TEAM, ENEMY_TEAM, PLAYER_ENEMY, ENEMY_PLAYER}
var players = []
var enemies = []

func _start_battle():
	pass


## Always use select if you intend to alter
func _select(team):
	match team:
		PLAYER_TEAM:
			return players.duplicate()
		ENEMY_TEAM:
			return enemies.duplicate()
		PLAYER_ENEMY:
			return players + enemies
		ENEMY_PLAYER:
			return enemies + players

func _get_min_time(team = PLAYER_ENEMY):
	var selection = _select(team)
	return selection.reduce(func(accum, fighter): return min(accum, fighter.time), INF)

func _get_max_time(team = PLAYER_ENEMY):
	var selection = _select(team)
	return selection.reduce(func(accum, fighter): return max(accum, fighter.time), 0)

func _progress_time():
	pass

# Tick time forwards by one turn.
func _time_tick():
	for enemy in _select(ENEMY_TEAM):
		await enemy.time_tick()
	for player in _select(PLAYER_TEAM):
		await player.time_tick()
