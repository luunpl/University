using System;
using System.Collections.Generic;
using System.IO;
using System.Numerics;
using System.Threading.Channels;
using System.Xml.Serialization;

namespace Collisions;

[XmlRoot("simulation", Namespace = "http://www.univ-grenoble-alpes.fr/trajSim")]
[Serializable]
public class ParticleSimulation {
    
    protected Environment _environment;

    [XmlElement("environment")]
    public Environment _Environment {
        init => _environment = value;
        get => _environment;
    }

    [XmlType(TypeName = "ParticleCaracs")]
    public class ParticleCaracs {
        [XmlText()] public uint _Nb { get; set; }
        [XmlAttribute("particleDim")] public uint _particleDim;
        [XmlAttribute("maxParticleSpeed")] public int _maxParticleSpeed;
    }
    protected ParticleCaracs _particleCaracs;
    [XmlElement("particles")] public ParticleCaracs _ParticleCaracs {
        init {
            _particleCaracs = value;
            _particles = new List<Particle>();
            for (uint i = 0; i < value._Nb; i++) {
                _particles.Add(new Particle(_environment, value._particleDim));
            }
        }
        get => _particleCaracs;
    }

    protected List<Particle> _particles;
    [XmlIgnore] public List<Particle> _Particles {
        get => _particles;
        private set => _particles = value;
    }

   
    //------------------ Protected methods -------------------
    protected void SetRandomizedPos() {
        foreach (var p in _particles) {
            p.SetRandomizedPos();
        }
    }

    protected void SetSpeed(float speed) {
        foreach (var p in _particles)
            p._Speed = speed;
    }

    //----------------------- Public methods ---------------------------
    public override string ToString() {
        string s = "[SIMULATION INFO]\n";
        s +=  "Particles (nb=" + _ParticleCaracs._Nb + " , max speed=" + _particleCaracs._maxParticleSpeed +
                   "):\n";
        s += "[ENVIRONMENT]\n"+_environment.ToString()+"\n";
        s += "[PARTICLES]\n";
        foreach (var p in _particles) {
            s += p.ToString();
        }

        return s;
    }
    
    //----------------------- Public virtual methods to override ---------------------------
    public virtual void Init() {
        SetRandomizedPos();
    }

    public virtual void Update() {
        if (Simulator._Instance._RecordInfo._When==Simulator.WhenToRecord.FREQUENCY && Simulator._Instance._CurrentTime% Simulator._Instance._TimesInfo._RecordFrequency ==0)
            Simulator._Instance.RecordData(_particles);
    }

    public virtual void Close() {
        Console.WriteLine("-> Closing simulation");
        Console.WriteLine("------------------------------------------------------------");
        Console.WriteLine("Time #" + Simulator._Instance._CurrentTime + "\n" + this);
        Console.WriteLine("------------------------------------------------------------");
        if (Simulator._Instance._RecordInfo._When==Simulator.WhenToRecord.END_OF_SIMULATION)
            Simulator._Instance.RecordData(_particles);
    }

}