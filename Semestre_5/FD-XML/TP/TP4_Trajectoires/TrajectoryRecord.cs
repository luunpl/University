using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Collisions;


[XmlRoot("trajectories", Namespace = "http://www.univ-grenoble-alpes.fr/trajSim")]
[Serializable]
public class TrajectoryRecord : Record {

    [XmlElement("trajectory")] public List<Trajectory> _trajectories;

    public override string ToString() {
        string s = "\n";
        foreach (var t in _trajectories)
            s += t.ToString() + "\n";
        return s;
    }


    public String ToSVG() {
        // TODO
        return String.Empty;
    }
}