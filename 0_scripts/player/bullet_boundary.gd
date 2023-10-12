extends Area2D
class_name BulletBoundary


func on_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	try_destroy_projectile(body)

func on_body_exited(body):
	try_destroy_projectile(body)
	
func try_destroy_projectile(body):
	var projectile = N.get_child(body, Projectile)
	if projectile:
		projectile.queue_free()
