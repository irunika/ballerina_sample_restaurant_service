package restaurant_information;

import ballerina.lang.jsons;
import ballerina.lang.strings;
import ballerina.doc;

@doc:Description {value:"This file contains the business logic of the application."}

@doc:Description {value:"Find restaurents by location"}
@doc:Param {value:"lat - latitude of the location"}
@doc:Param {value:"lon - longitude of the location"}
function findByLocation (string lat, string lon) (FindByLocationResponse) {
    json geocodeResponseJson = getGeocode(lat, lon);

    FindByLocationResponse findByLocationResponse = parseFindByLocationRespond(geocodeResponseJson);

    return findByLocationResponse;
}

@doc:Description {value:"Converts geocode response json to FindByLocationResponse"}
function parseFindByLocationRespond (json geocodeResponseJson) (FindByLocationResponse) {
    Location location = parseLocation(geocodeResponseJson);
    Restaurant[] restaurants = parseRestaurants(geocodeResponseJson.nearby_restaurants);

    FindByLocationResponse findByLocationRespond = {
                                                       location:location,
                                                       restaurants:restaurants
                                                   };
    return findByLocationRespond;
}

@doc:Description {value:"Parse restaurant array from restaurent array json"}
function parseRestaurants (json restaurantsJson) (Restaurant[]) {
    Restaurant[] restaurants = [];

    int restaurantCount = lengthof restaurantsJson;

    int i = 0;
    while (i < restaurantCount) {
        json restaurantJson = restaurantsJson[i];
        Restaurant restaurant = {
                                    id:(jsons:getString(restaurantJson, "restaurant.id")),
                                    name:(jsons:getString(restaurantJson, "restaurant.name")),
                                    address:(jsons:getString(restaurantJson, "restaurant.location.address")),
                                    thumb:(jsons:getString(restaurantJson, "restaurant.thumb")),
                                    featuredImage:(jsons:getString(restaurantJson, "restaurant.featured_image")),
                                    cuisines:(strings:split(jsons:getString(restaurantJson, "restaurant.cuisines"), ",")),
                                    rating:(jsons:getString(restaurantJson, "restaurant.user_rating.aggregate_rating")),
                                    ratingText:(jsons:getString(restaurantJson, "restaurant.user_rating.rating_text")),
                                    promotions:[]
                                };

        restaurants[i] = restaurant;
        i = i + 1;
    }

    return restaurants;
}

@doc:Description {value:"Parse location by geocode response json"}
function parseLocation (json geocodeResponseJson) (Location) {
    Location location = {
                            locationName:(jsons:getString(geocodeResponseJson, "location.title"))
                        };

    return location;
}



