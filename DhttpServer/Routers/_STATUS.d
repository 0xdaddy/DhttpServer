module Routers._STATUS;



class STATUS{

	/+ https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html =) +/ 
	enum{
		string OK = "HTTP/1.1 200 OK",
		string NOT_FOUND = "HTTP/1.1 404 Not Found",
		string FOUND = "HTTP/1.1 302 Found",
		string MOVED_PERMANETLY = "HTTP/1.1 301 Moved Permanently",
		string FORBIDDEN = "HTTP/1.1 403 Forbidden"
	}

}