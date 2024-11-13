using Godot;
using System;

public partial class DistCalc : Node2D
{
    [Export]
    public NodePath Node/Loc1;
    [Export]
    public NodePath Node/Loc2;

    private Node2D Loc1;
    private Node2D Loc2;

    public override void _Ready()
    {
        // Get the nodes from the scene
        Loc1 = GetNode<Node2D>(Node/Loc1);
        Loc2 = GetNode<Node2D>(Node/Loc2);

        // Calculate the distance between their positions
        float distance = Loc1.GlobalPosition.DistanceTo(Loc2.GlobalPosition);

        GD.Print("Distance between objects: " + distance);
    }
    public override void _Process(double delta)
	{
	}
}
