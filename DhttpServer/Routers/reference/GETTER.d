module Routers.reference.GETTER;

import std;

class templates{

	string PAGE(string _file_path){
		File file = File(_file_path, "r");
		string page;
		while (!file.eof()) { 
			string line = chomp(file.readln()); 
			page ~= line;
		}
		return page;
	}
}