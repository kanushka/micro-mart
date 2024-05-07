import ballerina/http;

type Product readonly & record {|
    string id;
    string name;
    decimal price;
    int quantity;
|};

service /products on new http:Listener(9090) {

    isolated resource function get .() returns Product[] {
        table<Product> key(id) products = table [
            {id: "P001", name: "Laptop", price: 1000.0, quantity: 10},
            {id: "P002", name: "Mouse", price: 20.0, quantity: 50},
            {id: "P003", name: "Keyboard", price: 50.0, quantity: 30},
            {id: "P004", name: "Monitor", price: 200.0, quantity: 20},
            {id: "P005", name: "Headset", price: 30.0, quantity: 40}
        ];
        return products.toArray();
    }

    isolated resource function post .(Product product) returns Product {
        return product;
    }

    isolated resource function get health() returns string {
        return "OK";
    }
}
