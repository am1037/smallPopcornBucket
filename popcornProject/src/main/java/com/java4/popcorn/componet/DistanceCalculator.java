package com.java4.popcorn.componet;

import org.springframework.stereotype.Component;

@Component
public class DistanceCalculator {

    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);

        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                        Math.sin(dLon / 2) * Math.sin(dLon / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        // Earth's radius in kilometers
        double EARTH_RADIUS = 6371;
        return EARTH_RADIUS * c;
    }

//    public static void main(String[] args) {
//        double lat1 = 37.3595963;
//        double lon1 = 127.1054328;
//        double lat2 = 37.5000263;
//        double lon2 = 127.0365456;
//
//        double distance = calculateDistance(lat1, lon1, lat2, lon2);
//        System.out.println("Distance: " + distance + " km");
//    }
}