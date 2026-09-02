package me.efesser.flauncher;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

public class WeatherReceiver extends BroadcastReceiver {
    public static final String ACTION_GENERIC_WEATHER = "nodomain.freeyourgadget.gadgetbridge.ACTION_GENERIC_WEATHER";
    public static final String PREFS_NAME = "lwidget_breezy_weather_data";
    public static final String KEY_WEATHER_JSON = "weather_json";

    public interface WeatherListener {
        void onWeatherUpdated(String weatherJson);
    }

    private static WeatherListener sListener;

    public static void setListener(WeatherListener listener) {
        sListener = listener;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent != null && ACTION_GENERIC_WEATHER.equals(intent.getAction())) {
            String weatherJson = intent.getStringExtra("WeatherJson");
            if (weatherJson != null && !weatherJson.isEmpty()) {
                SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
                prefs.edit().putString(KEY_WEATHER_JSON, weatherJson).apply();
                if (sListener != null) {
                    sListener.onWeatherUpdated(weatherJson);
                }
            }
        }
    }
}
