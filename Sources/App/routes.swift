import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello","vapor") { req in
        return "Hello, world!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        
        let name = try req.parameters.next(String.self)
        return "Hello, \(name)!"
    }
    
    router.post(InfoData.self, at: "info") { (req, data) -> InfoResponse in
        return InfoResponse(data: data)
        
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
    var name:String
    
}

struct InfoResponse: Content {
    let data: InfoData
}




