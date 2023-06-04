package com.java4.popcorn;

import javafx.application.Application;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import javafx.util.converter.DoubleStringConverter;

public class LocationFetcher extends Application {
    @Override
    public void start(Stage primaryStage) {
        ObjectProperty<Double> latitudeProperty = new SimpleObjectProperty<>();
        ObjectProperty<Double> longitudeProperty = new SimpleObjectProperty<>();

        // Get the location information
        javafx.scene.media.Media media = new javafx.scene.media.Media("file:/D:/test.mp4");
        javafx.scene.media.MediaPlayer mediaPlayer = new javafx.scene.media.MediaPlayer(media);

        mediaPlayer.setOnReady(new Runnable() {
            @Override
            public void run() {
                latitudeProperty.set((Double) mediaPlayer.getMedia().getMetadata().get("LocationLatitude"));
                longitudeProperty.set((Double) mediaPlayer.getMedia().getMetadata().get("LocationLongitude"));

                // Print the location information
                System.out.println("Latitude: " + latitudeProperty.get());
                System.out.println("Longitude: " + longitudeProperty.get());

                // Close the application
                primaryStage.close();
            }
        });

        StackPane root = new StackPane();
        Scene scene = new Scene(root, 300, 250);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}