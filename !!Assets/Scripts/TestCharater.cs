using Godot;
using System;

public partial class TestCharater : CharacterBody2D
{
	public const float maxSpeed = 300.0f;
	public const float accel = 1500.0f;

    //Drag vars
    private const float DragCoefficient = 0.1f;
    private const float IKDragFactor = 20.0f;
    private const float DragSmoothness = 0.1f;

    private const float MaxIKDistance = 200.0f;

    private Skeleton2D bones;
	private Node2D rightArm;
    private Node2D leftArm;
    private Node2D rightLeg;
    private Node2D leftLeg;

    public override void _Ready()
    {
        bones = GetNode<Skeleton2D>("Character Container/Bones");
		rightArm = GetNode<Node2D>("Character Container/IK Nodes/IKRArm");
        leftArm = GetNode<Node2D>("Character Container/IK Nodes/IKLArm");
        rightLeg = GetNode<Node2D>("Character Container/IK Nodes/IKRLeg");
        leftLeg = GetNode<Node2D>("Character Container/IK Nodes/IKLLeg");
    }

    public override void _PhysicsProcess(double delta)
	{
		float v = 0.0f;

		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("p1_left", "p1_right", "p1_up", "p1_down");
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

        Vector2 dragVector = -velocity * DragCoefficient;
        ApplyDragToIKTarget(rightArm, dragVector, (float)delta);
        ApplyDragToIKTarget(leftArm, dragVector, (float)delta);
        ApplyDragToIKTarget(rightLeg, dragVector, (float)delta);
        ApplyDragToIKTarget(leftLeg, dragVector, (float)delta);
    }
    private void ApplyDragToIKTarget(Node2D ikTarget, Vector2 dragVector, float delta)
    {
        // Current position of the IK target
        Vector2 currentPosition = ikTarget.GlobalPosition;

        Vector2 origin = GlobalPosition;

        // Calculate the new position based on drag
        Vector2 targetPosition = currentPosition + dragVector.Normalized() * IKDragFactor;

        // Smoothly interpolate to the new position
        Vector2 newPosition = currentPosition.Lerp(targetPosition, DragSmoothness);

        if (newPosition.DistanceTo(origin) > MaxIKDistance)
        {
            newPosition = origin + (newPosition - origin).Normalized() * MaxIKDistance;
        }

        // Update the IK target position
        ikTarget.GlobalPosition = newPosition;
}
}
