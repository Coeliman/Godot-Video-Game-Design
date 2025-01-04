using Godot;
using System;

public partial class TestCharater : CharacterBody2D
{
	public const float maxSpeed = 176.0f;
	public const float accel = 1250.0f;

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
    private Bone2D rightShoulder;
    private Bone2D leftShoulder;
    private Bone2D rightHip;
    private Bone2D leftHip;

    public override void _Ready()
    {
        bones = GetNode<Skeleton2D>("Character Container/Bones");
		rightArm = GetNode<Node2D>("Character Container/IK Nodes/IKRArm");
        leftArm = GetNode<Node2D>("Character Container/IK Nodes/IKLArm");
        rightLeg = GetNode<Node2D>("Character Container/IK Nodes/IKRLeg");
        leftLeg = GetNode<Node2D>("Character Container/IK Nodes/IKLLeg");
        rightShoulder = GetNode<Bone2D>("Character Container/Bones/Pelvis/Chest/Right_Shoulder");
        leftShoulder = GetNode<Bone2D>("Character Container/Bones/Pelvis/Chest/Left_Shoulder");
        rightHip = GetNode<Bone2D>("Character Container/Bones/Pelvis/Right_Hip");
        leftHip = GetNode<Bone2D>("Character Container/Bones/Pelvis/Left_Hip");
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
        ApplyDragToIKTarget(rightArm, dragVector, (float)delta, 0);
        ApplyDragToIKTarget(leftArm, dragVector, (float)delta, 1);
        ApplyDragToIKTarget(rightLeg, dragVector, (float)delta, 2);
        ApplyDragToIKTarget(leftLeg, dragVector, (float)delta, 3);
    }
    private void ApplyDragToIKTarget(Node2D ikTarget, Vector2 dragVector, float delta, int num)
    {
        // Current position of the IK target
        Vector2 currentPosition = ikTarget.GlobalPosition;

        // Calculate the new position based on drag
        Vector2 targetPosition = currentPosition + dragVector.Normalized() * IKDragFactor;

        // Smoothly interpolate to the new position
        Vector2 newPosition = currentPosition.Lerp(targetPosition, DragSmoothness);

        Vector2 origin = GlobalPosition;
        switch (num)
        {
            case 0:
                origin = rightShoulder.GlobalPosition;
                /*
                float angle = rightShoulder.GetBoneAngle();

                float minAngle = Mathf.DegToRad(90);
                float maxAngle = Mathf.DegToRad(270);

                angle = Mathf.Clamp(angle, minAngle, maxAngle);

                rightShoulder.SetBoneAngle(angle);
                */
                break;

            case 1:
                origin = leftShoulder.GlobalPosition;
                break;

            case 2:
                origin = rightHip.GlobalPosition;
                break;

            case 3:
                origin = leftHip.GlobalPosition;
                break;
        }

        if (newPosition.DistanceTo(origin) > MaxIKDistance)
        {
            newPosition = origin + (newPosition - origin).Normalized() * MaxIKDistance;
        }


        // Update the IK target position
        ikTarget.GlobalPosition = newPosition;
    }
}
