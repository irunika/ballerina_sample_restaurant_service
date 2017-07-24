package restaurant_information;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.doc;

@doc:Description {value:"This file is responsible to present(or publish) information"}

@http:configuration {basePath:"/api/v1/restaurant-service"}
service<http> RestaurentService {
    @http:GET {}
    @http:Path {value:"/find-by-location"}
    resource findByLocation (message request, @http:QueryParam {value:"lat"} string lat, @http:QueryParam {value:"lon"} string lon) {
        FindByLocationResponse findByLocationResponse = findByLocation(lat, lon);

        system:println(findByLocationResponse);

        //response
        var responseJson, error = <json>findByLocationResponse;
        system:println(error);
        system:print(responseJson);
        message response = {};
        messages:setJsonPayload(response, responseJson);

        reply response;
    }
}