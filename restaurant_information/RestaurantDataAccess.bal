package restaurant_information;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.doc;

string zomotoToken = "c248055395ca62ed07d0db375334650e";
string zomotoEndpointUrl = "https://developers.zomato.com/api/v2.1/";

@doc:Description {value:"This file contains data access methods of the applicaton"}

@doc:Description {value:"Call online service and get geocode response"}
function getGeocode(string lat, string lon) (json) {
    message geocodeResponseMessage = {};

    //create request
    http:ClientConnector geocodeEP = create http:ClientConnector(zomotoEndpointUrl);
    messages:setHeader(geocodeResponseMessage, "user-key", zomotoToken);

    //process respond
    geocodeResponseMessage = http:ClientConnector.get(geocodeEP, "geocode?lat=" + lat + "&lon=" + lon, geocodeResponseMessage);
    json geocodeResponseJson = messages:getJsonPayload(geocodeResponseMessage);
    return geocodeResponseJson;
}