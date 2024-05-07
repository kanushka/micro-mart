import ballerina/http;
import ballerina/io;
import ballerina/os;

type Order readonly & record {|
    string id;
    string productId;
    int quantity;
    decimal price;
    decimal total;
    string? userId;
|};

type Product readonly & record {|
    string id;
    string name;
    decimal price;
    int quantity;
|};

service /orders on new http:Listener(9090) {

    isolated resource function get .() returns Order[]|http:ClientError {
        io:println("Order service invoked. Fetching products from the product service.");
        string productServiceUrl = os:getEnv("PRODUCT_SERVICE_URL");
        http:Client productsEp = check new (url = productServiceUrl);
        Product[] products = check productsEp->/;
        io:println("Products: ");
        io:println(products);

        table<Order> key(id) orders = table [
            {id: "1", productId: "P001", quantity: 1, price: 1000.0, total: 2000.0, userId: "U001"},
            {id: "2", productId: "P002", quantity: 2, price: 20.0, total: 40.0, userId: "U002"},
            {id: "3", productId: "P004", quantity: 2, price: 400.0, total: 400.0, userId: "U003"}
        ];
        return orders.toArray();
    }

    isolated resource function post .(Order 'order) returns Order {
        return 'order;
    }

    isolated resource function get health() returns string {
        return "OK";
    }
}
