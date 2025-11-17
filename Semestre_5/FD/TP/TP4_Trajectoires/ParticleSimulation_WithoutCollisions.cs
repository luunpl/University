using System;
using System.Collections.Generic;
using System.Numerics;
using System.Threading.Channels;
using System.Xml.Serialization;

namespace Collisions;

[XmlRoot("simulation", Namespace = "http://www.univ-grenoble-alpes.fr/trajSim")]
[Serializable]
public class ParticleSimulation_WithoutCollisions : ParticleSimulation{
    
    
    //------------------ Private methods -------------------
    private void SetRandomizedSpeed() {
        foreach (var p in _particles)
            p.SetRandomizedSpeed(_ParticleCaracs._maxParticleSpeed);
    }
    
    private void MoveParticles() {
        foreach (var p in _particles)
            p.Move();
    }

    //----------------------- Public methods ---------------------------
    public override void Init() {
        base.Init();
        SetRandomizedSpeed();
    }

    public override void Update() {
        base.Update();
        MoveParticles();
    }

    public override void Close() {
        base.Close();
        Console.WriteLine("Simulation closed");
    }
    
}