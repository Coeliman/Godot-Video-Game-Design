using Godot;
using System;

public partial class TestCharater2 : CharacterBody2D {

    public const float maxSpeed = 300.0f;//max velocity possible (speed cannot go higher than this)
    public const float accel = 1500.0f;//acceleration of character for every tick delta
    public override void _PhysicsProcess(double delta) {//_PhysicsProcess must be called exactly to integrate with Godot

        float v = 0.0f;//net velocity, no direction

        Vector2 velocity = Velocity;//velocity vector
        Vector2 direction = Input.GetVector("p2_left", "p2_right", "p2_up", "p2_down"); //direction, no velocity

        //no natural deceleration, the user must manualy decelerate themselves (mimcs zero-G)
        if (direction != Vector2.Zero) {//checks if there is curently an input
            if (maxSpeed - v > accel) {//if diffrence between v and maxSpeed is greater than accel
                v += accel;//adds accel to v
                velocity += direction * v * (float)delta;//velocity and direction multiplied to get vector (delta for time)
            } else { //if diffrence between maxSpeed and v is less than accel then sets v to maxSpeed
                v = maxSpeed;//sets v to maxSpeed
                velocity += direction * v * (float)delta;//velocity and direction multiplied to get vector (delta for time)
            }
        }

        Velocity = velocity;//sets super(Velocity) to our velocity vector
        MoveAndSlide();//moves character
    }
}

