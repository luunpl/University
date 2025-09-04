using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;

namespace Collisions;

[XmlRoot("simulator", Namespace = "http://www.univ-grenoble-alpes.fr/trajSim")]
[Serializable]
public class Simulator {

    private static Simulator _instance;
    private ParticleSimulation _simulation;
    private Record _record;

    public static Simulator _Instance { 
        get {
            if (_instance == null) {
                XMLManager<Simulator> _xmlSimulator = new XMLManager<Simulator>();
                _instance = _xmlSimulator.Load("./XML/Simulator.xml");
            }
            return _instance; 
        }
    }

    public enum RecordType {
        [XmlEnum("Trajectories")] TRAJECTORIES,
        [XmlEnum("Positions")] POSITIONS
    }

    public enum WhenToRecord {
        [XmlEnum("EndOfSimulation")] END_OF_SIMULATION,
        [XmlEnum("Frequency")] FREQUENCY
    }
    
    [XmlType(TypeName = "RecordInfo")]
    public class RecordInfo {
        [XmlElement("recordType")] public RecordType _RecordType { init; get; }
        [XmlElement("when")] public WhenToRecord _When{ init; get; }
        [XmlElement("path")] public String _Path{ init; get; }
    }
    [XmlElement("recordInfo")] public RecordInfo _RecordInfo { init; get; }
    private Type _recordType;
    
    [XmlType(TypeName = "SimulationInfo")]
    public class SimulationInfo {
        [XmlElement("classname")] public String _ClassName { init; get; }
        [XmlElement("path")] public String _Path{ init; get; }
        [XmlElement("filename")] public String _Filename{ init; get; }
    }
    [XmlElement("simulationInfo")] public SimulationInfo _SimulationInfo { init; get; }
    
    
    [XmlType(TypeName = "TimeInfo")]
    public class TimeInfo {
        [XmlElement("simulationTime")] public uint _SimulationTime { init; get; }
        [XmlElement("recordFrequency")] public uint _RecordFrequency { init; get; }
        [XmlElement("displayUpdate")] public uint _DisplayUpdate { init; get; }
    }
    [XmlElement("timeInfo")] public TimeInfo _TimesInfo { init; get; }

    [XmlIgnore] public uint _CurrentTime { private set; get; }

    
    //----------------------- Public methods ----------------------

    public void Init() {
        // instanciation par sérialisation d'une simulation à partir du type donné dans le xml
        Type simulationType = Type.GetType("Collisions." + _SimulationInfo._ClassName);
        using (TextReader reader = new StreamReader(_SimulationInfo._Path+_SimulationInfo._Filename)) {
            // create an instance of the XmlSerializer
            var xml = new XmlSerializer(simulationType);
            // deserialize and casts the text into the type simulationType
            _simulation =  (ParticleSimulation) xml.Deserialize(reader);
        }
        // instanciation d'un enregistrement à partir du type donné dans le xml
        switch (_RecordInfo._RecordType) {
            case RecordType.TRAJECTORIES : 
                _recordType = Type.GetType("Collisions.TrajectoryRecord");
                break;
            case RecordType.POSITIONS : 
                _recordType = Type.GetType("Collisions.PositionRecord");
                break;
        }
        _record = (Record) Activator.CreateInstance(_recordType);
    }

    
    
    public void Run() {
        _simulation.Init();
        for (_CurrentTime = 0; _CurrentTime < _TimesInfo._SimulationTime; _CurrentTime++) {
            _simulation.Update();
            if (_CurrentTime % _Instance._TimesInfo._DisplayUpdate == 0) {
                Console.WriteLine("------------------------------------------------------------");
                Console.WriteLine("Time #" + _CurrentTime + "\n" + _simulation);
                Console.WriteLine("------------------------------------------------------------");
            }
        }
        _simulation.Close();
    }
    
    
    public void RecordData(List<Particle> particles) {
        Console.WriteLine("\n -> recording !");
        // TODO: 
        // - update the TrajectoryRecord or PositionRecord record
        // - generate XML string using a XMLManager.GetXML
        // - generate basefilename : if Frequency -> record_$currenttime / if EndOfSimulation -> record 
        // - if output = XML or Both, save to XML file
        // - if output = SVG or Both, use XSLT to generate SVG from XML string [add this functionality to XMLManager]
        // - ... and save SVG file
    }

   
    
    public override string ToString() {
        String s = String.Empty;
        s += "Simulation infos :\n";
        s += "  - classname :" + _SimulationInfo._ClassName + "\n";
        s += "  - path :" + _SimulationInfo._Path + "\n";
        s += "  - filename :" + _SimulationInfo._Filename + "\n";
        s += "Record infos :\n";
        s += "  - recordType :" + _RecordInfo._RecordType + "\n";
        s += "  - when :" + _RecordInfo._When + "\n";
        s += "  - path :" + _RecordInfo._Path + "\n";
        s += "Time infos :\n";
        s += "  - simulationTime :" + _TimesInfo._SimulationTime + "\n"; 
        s += "  - recordfrequency :" + _TimesInfo._RecordFrequency + "\n";
        s += "  - displayUpdate :" + _TimesInfo._DisplayUpdate + "\n";
        return s;
    }
    
}