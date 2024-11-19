using Godot;
using System;

public partial class Astro2Movement : CharacterBody2D
{
	public const float maxSpeed = 300.0f;
	public const float accel = 1500.0f;

	public override void _PhysicsProcess(double delta)
	{
		float v = 0.0f;

		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			if (maxSpeed - v > accel)
			{
				v += accel;
				velocity += direction * v * (float)delta;
			}
			else
			{
				v = maxSpeed;
				velocity += direction * v * (float)delta;
			}
		}

		MoveAndSlide();

		if (IsOnWall())
		{
			if (GetWallNormal() != Vector2.Zero)
			{
				// Only cancel the corresponding velocity component
				if (Math.Abs(GetWallNormal().X) > Math.Abs(GetWallNormal().Y))
				{
					velocity.X = 0.0f;
				}
				else
				{
					velocity.Y = 0.0f;
				}
			}
		}

		Velocity = velocity;
		//MoveAndSlide();
	}
}
