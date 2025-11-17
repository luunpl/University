using System;
using System.Numerics;
using Collisions;
using Environment = Collisions.Environment;


internal class Program {
    public static void Main(string[] args) {
        Simulator._Instance.Init();
        Console.WriteLine(Simulator._Instance.ToString());
        Simulator._Instance.Run();
    }
}