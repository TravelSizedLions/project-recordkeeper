class_name Charger

var __charge: float = -1
var __max_charge_time: float = 1

func start_charge(fixedDelta: float):
	__charge = fixedDelta

func handle_charge(fixedDelta: float):
	if __charge > 0:
		__charge += fixedDelta

func percent_charged():
	return clamp(__charge, 0, __max_charge_time)/__max_charge_time

func reset_charge():
	__charge = -1

func set_charge_percent(percent: float):
	__charge = clamp(percent*__max_charge_time, 0, __max_charge_time)

func set_max_charge_time(time: float):
	__max_charge_time = time

func is_charging():
	return __charge > 0
