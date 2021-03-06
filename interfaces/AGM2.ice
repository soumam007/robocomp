#ifndef ROBOCOMPAGM2_ICE
#define ROBOCOMPAGM2_ICE

module RoboCompAGM
{

	struct StringPair
	{
		string first;
		string second;
	};

	vector<StringPair> StringDictionary;

	struct Node
	{
		StringDictionary attributes;
		int nodeIdentifier;
		string nodeType;
	};

	sequence <Node> NodeSequence;

	struct Edge
	{
		StringDictionary attributes;
		int a;
		int b;
		string edgeType;
	};

	sequence <Edge> EdgeSequence;

	struct World
	{
		NodeSequence nodes;
		EdgeSequence edges;
		int version;
	};

	struct Action
	{
		string name;
		StringDictionary symbols;
	};

	sequence <Action> ActionSequence;

	struct Plan
	{
		ActionSequence actions;
		float cost;
	};

	struct StructuralChangeProposal
	{
		RoboCompAGMWorldModel::World w;
		string sender;
		string log;
	};

	interface AGMDSRService
	{
		// Agents' API
		void structuralChangeProposal(StructuralChangeProposal, int ret); // Ok, Locked, OldModel, InvalidChange
		void symbolUpdate(RoboCompAGMWorldModel::Node n, int ret);
		void symbolsUpdate(RoboCompAGMWorldModel::NodeSequence ns, int ret);
		void edgeUpdate(RoboCompAGMWorldModel::Edge e, int ret);
		void edgesUpdate(RoboCompAGMWorldModel::EdgeSequence es, int ret);
		void getModel(bool unused, RoboCompAGMWorldModel::World ret);
		void getNode(int identifier, RoboCompAGMWorldModel::Node ret);
		void getEdge(RoboCompAGMWorldModel::Edge input, RoboCompAGMWorldModel::Edge ret);
	}

	interface AGMDSRTopic
	{
		void structuralChange(RoboCompAGMWorldModel::World w);
		void symbolsUpdated(RoboCompAGMWorldModel::NodeSequence modification);
		void edgesUpdated(RoboCompAGMWorldModel::EdgeSequence modification);
	};



	interface AGMExecutiveService
	{
		void setMission(string path, int ret);
		void getPlan(bool unused, Plan plan);
		void getTarget(bool unused, string target);
		void broadcastModel(bool unusedI, bool unusedR);
		void broadcastPlan(bool unusedI, bool unusedR);
	};


	interface AGMExecutiveTopic
	{
		void planUpdate(Plan plan);
	};

}

#endif
