extends Resource
class_name CompanionSettings

## The "Rubber Band" strength of blizz's follow behavior.
## I.E., the 'a' value of the linear interpolation between companion and player.
@export var band_strength: float = 0.5

## How close the companion is allowed to get to the player. Stops following within this distance.
@export var tail_distance: float = 50
