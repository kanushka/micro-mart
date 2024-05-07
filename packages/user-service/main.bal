import ballerina/http;

type User readonly & record {|
    string id;
    string name;
|};

service /users on new http:Listener(9090) {

    isolated resource function get .() returns User[] {
        table<User> key(id) users = table [
            {id: "1", name: "Alice"},
            {id: "2", name: "Bob"},
            {id: "3", name: "Charlie"},
            {id: "4", name: "David"},
            {id: "5", name: "Eve"},
                    ];
        return users.toArray();
    }

    isolated resource function post .(User user) returns User {
        return user;
    }

    isolated resource function get health() returns string {
        return "OK";
    }
}
