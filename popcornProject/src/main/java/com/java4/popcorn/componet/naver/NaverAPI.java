package com.java4.popcorn.componet.naver;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Component
public class NaverAPI {
    public static void main(String[] args) {
        String url = "https://geolocation.apigw.ntruss.com/geolocation/v2/geoLocation";
        try {
            HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(System.currentTimeMillis()));
            con.setRequestProperty("x-ncp-iam-access-key", "apaqutnndn");
            con.setRequestProperty("x-ncp-apigw-signature-v2", "Tpd4XqCveoqk4ALIJK6FLTptt76pCnWq9gdrEsJy");
            System.out.println(con.getResponseCode());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public String byAddress(String address) throws Exception {
        String query = "?query=" + URLEncoder.encode(address, "UTF-8");
        String url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode" + query;
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", "apaqutnndn");
        con.setRequestProperty("X-NCP-APIGW-API-KEY", "Tpd4XqCveoqk4ALIJK6FLTptt76pCnWq9gdrEsJy");
        con.setRequestProperty("Accept", "application/json");

        int responseCode = con.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String line;
        StringBuilder response = new StringBuilder();

        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();

        return response.toString();
    }

    public Double[] getCoordinate(String address) throws Exception {
        try {
            Double[] results = new Double[2];
            ObjectMapper om = new ObjectMapper();
            NaverMapResponse nmr = om.readValue(new NaverAPI().byAddress(address), NaverMapResponse.class);
            results[0] = (nmr.getAddresses().get(0).getX());
            results[1] = (nmr.getAddresses().get(0).getY());
            return results;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
