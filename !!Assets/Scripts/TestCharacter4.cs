using Godot;
using System;

public partial class TestCharacter4 : CharacterBody2D
{
	public const float maxSpeed4 = 300.0f;
	public const float accel4 = 1500.0f;
	public override void _Ready()
	{
		// Set the scale to 0.25 of the original size
		Scale = new Vector2(0.25f, 0.25f);
	}
	public override void _PhysicsProcess(double delta)
	
	{

		float v = 0.0f;

		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("p4_left", "p4_right", "p4_up", "p4_down");
		if (direction != Vector2.Zero)
		{
			if (maxSpeed4 - v > accel4)
			{
				v += accel4;
				velocity += direction * v * (float)delta;
			}
			else
			{
				v = maxSpeed4;
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
