package restaurant_information;

import ballerina.doc;

@doc:Description {value:"Find restaurents by location response"}
struct FindByLocationResponse {
    Location location;
    Restaurant[] restaurants;
}