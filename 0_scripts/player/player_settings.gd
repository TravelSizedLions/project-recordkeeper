extends Resource
class_name PlayerSettings

@export_group('Health Settings')
## The maximum health of this player character
@export var max_health: float = 10

## How fast this player character regenerates health
@export var regen_speed: float = 0.2

@export_group('Movement Settings')
## How fast the player moves (in .1 pixel/second units)
@export var speed = 300.0

## Initial jump speed (in .1 pixel/second^2 units)
@export var jump_force = -400.0


@export_group('Weapon Settings')

## The projectile to use.
@export var projectile: PackedScene

## Projectile speed (in .1 pixel/second units)
@export var projectile_speed = 300

## In seconds
@export var fire_rate = 0.25


@export_group('Swap Settings')

## the player's sprite frames
@export var sprites: SpriteFrames

## the player's starting state
@export var start_state: GDScript
