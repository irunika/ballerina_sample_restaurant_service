package restaurant_information;

import ballerina.doc;

@doc:Description {value:"Restaurant entity"}
struct Restaurant {
    string id;
    string name;
    string address;
    string thumb;
    string featuredImage;
    string[] cuisines;
    string rating;
    string ratingText;
    string[] promotions;
}