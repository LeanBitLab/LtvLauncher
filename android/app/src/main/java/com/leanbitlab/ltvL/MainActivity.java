/*
 * FLauncher
 * Copyright (C) 2021  Oscar Rojas
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

package com.leanbitlab.ltvL;

import android.content.Context;
import android.content.Intent;
import android.content.pm.*;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.ConnectivityManager;
import android.net.NetworkCapabilities;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Pair;
import android.media.tv.TvInputManager;
import android.media.tv.TvInputInfo;
import android.media.tv.TvContract;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.ByteArrayOutputStream;
import android.app.usage.NetworkStats;
import android.app.usage.NetworkStatsManager;
import android.app.AppOpsManager;
import android.os.RemoteException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

import java.io.ByteArrayOutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletionService;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorCompletionService;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import android.service.notification.StatusBarNotification;
import android.content.ComponentName;

public class MainActivity extends FlutterActivity {
    private final String METHOD_CHANNEL = "me.efesser.flauncher/method";
    private final String APPS_EVENT_CHANNEL = "me.efesser.flauncher/event_apps";
    private final String NETWORK_EVENT_CHANNEL = "me.efesser.flauncher/event_network";
    private final String NOTIFICATIONS_EVENT_CHANNEL = "me.efesser.flauncher/event_notifications";
    private final String WEATHER_EVENT_CHANNEL = "me.efesser.flauncher/event_weather";
    private MethodChannel.Result pendingPermissionResult;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();

        new MethodChannel(messenger, METHOD_CHANNEL).setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "getApplications" -> result.success(getApplications());
                case "getApplicationBanner" -> result.success(getApplicationBanner(call.arguments()));
                case "getApplicationIcon" -> result.success(getApplicationIcon(call.arguments()));
                case "launchActivityFromAction" -> result.success(launchActivityFromAction(call.arguments()));
                case "launchApp" -> result.success(launchApp(call.arguments()));
                case "openUrl" -> result.success(openUrl(call.arguments()));
                case "openSettings" -> result.success(openSettings());
                case "openScreensaverSettings" -> result.success(openScreensaverSettings());
                case "openAppInfo" -> result.success(openAppInfo(call.arguments()));
                case "uninstallApp" -> result.success(uninstallApp(call.arguments()));
                case "isDefaultLauncher" -> result.success(isDefaultLauncher());
                case "checkForGetContentAvailability" -> result.success(checkForGetContentAvailability());
                case "startAmbientMode" -> result.success(startAmbientMode());
                case "getActiveNetworkInformation" -> result.success(getActiveNetworkInformation());
                case "getDailyDataUsage" -> {
                    long usage = getDailyDataUsage();
                    if (usage == -1) {
                        result.error("PERMISSION_DENIED", "Usage stats permission not granted", null);
                    } else {
                        result.success(usage);
                    }
                }
                case "getWeeklyDataUsage" -> {
                    long usage = getWeeklyDataUsage();
                    if (usage == -1) {
                        result.error("PERMISSION_DENIED", "Usage stats permission not granted", null);
                    } else {
                        result.success(usage);
                    }
                }
                case "getMonthlyDataUsage" -> {
                    long usage = getMonthlyDataUsage();
                    if (usage == -1) {
                        result.error("PERMISSION_DENIED", "Usage stats permission not granted", null);
                    } else {
                        result.success(usage);
                    }
                }
                case "checkUsageStatsPermission" -> result.success(checkUsageStatsPermission());
                case "requestUsageStatsPermission" -> {
                    requestUsageStatsPermission();
                    result.success(null);
                }
                case "checkWriteSettingsPermission" -> result.success(checkWriteSettingsPermission());
                case "requestWriteSettingsPermission" -> result.success(requestWriteSettingsPermission());
                case "setSystemBrightness" -> {
                    int brightness = call.argument("brightness");
                    result.success(setSystemBrightness(brightness));
                }
                case "openDefaultLauncherSettings" -> result.success(openDefaultLauncherSettings());
                case "openWifiSettings" -> result.success(openWifiSettings());
                case "openVpnSettings" -> result.success(openVpnSettings());
                case "getTvInputs" -> result.success(getTvInputs());
                case "launchTvInput" -> result.success(launchTvInput(call.arguments()));
                case "checkNotificationListenerPermission" -> result.success(checkNotificationListenerPermission());
                case "requestNotificationListenerPermission" -> result.success(requestNotificationListenerPermission());
                case "getActiveNotifications" -> result.success(getActiveNotifications());
                case "dismissNotification" -> {
                    String key = call.argument("key");
                    result.success(dismissNotification(key));
                }
                case "dismissAllNotifications" -> result.success(dismissAllNotifications());
                case "checkOverlayPermission" -> result.success(checkOverlayPermission());
                case "requestOverlayPermission" -> result.success(requestOverlayPermission());
                case "checkAccessibilityPermission" -> result.success(isAccessibilityServiceEnabled());
                case "requestAccessibilityPermission" -> result.success(openAccessibilitySettings());
                case "checkWatchNextPermission" -> result.success(checkWatchNextPermission());
                case "requestWatchNextPermission" -> {
                    if (checkWatchNextPermission()) {
                        result.success(true);
                    } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        if (pendingPermissionResult != null) {
                            result.error("ALREADY_REQUESTING", "A permission request is already in progress", null);
                        } else {
                            pendingPermissionResult = result;
                            requestPermissions(new String[]{"android.permission.READ_TV_LISTINGS"}, 1002);
                        }
                    } else {
                        result.success(true);
                    }
                }
                case "getWatchNextPrograms" -> result.success(getWatchNextPrograms());
                case "getWatchNextPoster" -> {
                    String posterArtUri = call.argument("posterArtUri");
                    result.success(getWatchNextPoster(posterArtUri));
                }
                case "launchWatchNextProgram" -> {
                    String intentUri = call.argument("intentUri");
                    result.success(launchWatchNextProgram(intentUri));
                }
                case "getLatestWeatherData" -> result.success(getLatestWeatherData());
                case "isBreezyWeatherInstalled" -> result.success(isBreezyWeatherInstalled());
                case "openBreezyWeather" -> result.success(openBreezyWeather());
                case "getPackageName" -> result.success(getPackageName());
                case "playClickSound" -> {
                    getWindow().getDecorView().playSoundEffect(android.view.SoundEffectConstants.CLICK);
                    result.success(null);
                }
                default -> throw new IllegalArgumentException();
            }
        });

        new EventChannel(messenger, APPS_EVENT_CHANNEL).setStreamHandler(
                new LauncherAppsEventStreamHandler(this));

        new EventChannel(messenger, NETWORK_EVENT_CHANNEL).setStreamHandler(
                new NetworkEventStreamHandler(this));

        new EventChannel(messenger, NOTIFICATIONS_EVENT_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    private LauncherNotificationListenerService.NotificationListener listener;

                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        listener = () -> {
                            runOnUiThread(() -> {
                                try {
                                    events.success(getActiveNotifications());
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            });
                        };
                        LauncherNotificationListenerService.registerListener(listener);
                        // Send current state immediately
                        listener.onNotificationChanged();
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        if (listener != null) {
                            LauncherNotificationListenerService.unregisterListener(listener);
                            listener = null;
                        }
                    }
                }
        );

        new EventChannel(messenger, WEATHER_EVENT_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        WeatherReceiver.setListener(weatherJson -> {
                            runOnUiThread(() -> {
                                try {
                                    events.success(weatherJson);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            });
                        });
                        String latest = getLatestWeatherData();
                        if (latest != null) {
                            events.success(latest);
                        }
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        WeatherReceiver.setListener(null);
                    }
                }
        );
    }

    private List<Map<String, Serializable>> getApplications() {
        ExecutorService executor = Executors.newFixedThreadPool(4);
        CompletionService<Pair<Boolean, List<ResolveInfo>>> queryIntentActivitiesCompletionService = new ExecutorCompletionService<>(
                executor);
        queryIntentActivitiesCompletionService.submit(() -> Pair.create(false, queryIntentActivities(false)));
        queryIntentActivitiesCompletionService.submit(() -> Pair.create(true, queryIntentActivities(true)));
        List<ResolveInfo> tvActivitiesInfo = null;
        List<ResolveInfo> nonTvActivitiesInfo = null;

        int completed = 0;
        while (completed < 2) {
            try {
                var activitiesInfo = queryIntentActivitiesCompletionService.take().get();

                if (!activitiesInfo.first) {
                    tvActivitiesInfo = activitiesInfo.second;
                } else {
                    nonTvActivitiesInfo = activitiesInfo.second;
                }
            } catch (InterruptedException | ExecutionException ignored) {
            } finally {
                completed += 1;
            }
        }

        CompletionService<Map<String, Serializable>> completionService = new ExecutorCompletionService<>(executor);

        List<Map<String, Serializable>> applications = new ArrayList<>(
                tvActivitiesInfo.size() + nonTvActivitiesInfo.size());

        boolean settingsPresent = false;
        int appCount = 0;
        for (ResolveInfo tvActivityInfo : tvActivitiesInfo) {
            if (!settingsPresent) {
                settingsPresent = tvActivityInfo.activityInfo.packageName.equals("com.android.tv.settings");
            }

            completionService.submit(() -> buildAppMap(tvActivityInfo.activityInfo, false, null));
            appCount += 1;
        }

        for (ResolveInfo nonTvActivityInfo : nonTvActivitiesInfo) {
            boolean nonDuplicate = true;

            if (!settingsPresent) {
                settingsPresent = nonTvActivityInfo.activityInfo.packageName.equals("com.android.settings");
            }

            for (ResolveInfo tvActivityInfo : tvActivitiesInfo) {
                if (tvActivityInfo.activityInfo.packageName.equals(nonTvActivityInfo.activityInfo.packageName)) {
                    nonDuplicate = false;
                    break;
                }
            }

            if (nonDuplicate) {
                appCount += 1;
                completionService.submit(() -> buildAppMap(nonTvActivityInfo.activityInfo, true, null));
            }
        }

        while (appCount > 0) {
            try {
                Future<Map<String, Serializable>> appMap = completionService.take();
                applications.add(appMap.get());
            } catch (InterruptedException | ExecutionException ignored) {
            } finally {
                appCount -= 1;
            }
        }

        executor.shutdown();

        if (!settingsPresent) {
            PackageManager packageManager = getPackageManager();
            Intent settingsIntent = new Intent(Settings.ACTION_SETTINGS);
            ActivityInfo activityInfo = settingsIntent.resolveActivityInfo(packageManager, 0);

            if (activityInfo != null) {
                applications.add(buildAppMap(activityInfo, false, Settings.ACTION_SETTINGS));
            }
        }

        return applications;
    }

    public Map<String, Serializable> getApplication(String packageName) {
        Map<String, Serializable> map = new java.util.HashMap<>();
        PackageManager packageManager = getPackageManager();
        Intent intent = packageManager.getLeanbackLaunchIntentForPackage(packageName);

        if (intent == null) {
            intent = packageManager.getLaunchIntentForPackage(packageName);
        }

        if (intent != null) {
            ActivityInfo activityInfo = intent.resolveActivityInfo(getPackageManager(), 0);

            if (activityInfo != null) {
                map = buildAppMap(activityInfo, false, null);
            }
        }

        return map;
    }

    private byte[] getApplicationBanner(String packageName) {
        byte[] imageBytes = new byte[0];

        PackageManager packageManager = getPackageManager();
        try {
            ApplicationInfo info = packageManager.getApplicationInfo(packageName, 0);
            Drawable drawable = info.loadBanner(packageManager);

            if (drawable != null) {
                imageBytes = drawableToByteArray(drawable);
            }
        } catch (PackageManager.NameNotFoundException ignored) {
        }

        return imageBytes;
    }

    private byte[] getApplicationIcon(String packageName) {
        byte[] imageBytes = new byte[0];

        PackageManager packageManager = getPackageManager();
        try {
            ApplicationInfo info = packageManager.getApplicationInfo(packageName, 0);
            Drawable drawable = info.loadIcon(packageManager);

            if (drawable != null) {
                imageBytes = drawableToByteArray(drawable);
            }
        } catch (PackageManager.NameNotFoundException ignored) {
        }

        return imageBytes;
    }

    private List<ResolveInfo> queryIntentActivities(boolean sideloaded) {
        String category;
        if (sideloaded) {
            category = Intent.CATEGORY_LAUNCHER;
        } else {
            category = Intent.CATEGORY_LEANBACK_LAUNCHER;
        }

        // NOTE: Would be nice to query the applications that match *either* of the
        // above categories
        // but from the addCategory function documentation, it says that it will "use
        // activities
        // that provide *all* the requested categories"
        Intent intent = new Intent(Intent.ACTION_MAIN)
                .addCategory(category);

        return getPackageManager()
                .queryIntentActivities(intent, 0);
    }

    private Map<String, Serializable> buildAppMap(ActivityInfo activityInfo, boolean sideloaded, String action) {
        PackageManager packageManager = getPackageManager();

        String applicationName = activityInfo.loadLabel(packageManager).toString(),
                applicationVersionName = "";
        try {
            applicationVersionName = packageManager.getPackageInfo(activityInfo.packageName, 0).versionName;
        } catch (PackageManager.NameNotFoundException ignored) {
        }

        Map<String, Serializable> appMap = new HashMap<>();
        appMap.put("name", applicationName);
        appMap.put("packageName", activityInfo.packageName);
        appMap.put("version", applicationVersionName);
        appMap.put("sideloaded", sideloaded);

        if (action != null) {
            appMap.put("action", action);
        }
        return appMap;
    }

    private boolean launchActivityFromAction(String action) {
        // Prevent Intent Action Injection by only allowing known actions
        if (Settings.ACTION_SETTINGS.equals(action)) {
            return tryStartActivity(new Intent(action));
        }
        return false;
    }

    private boolean launchApp(String packageName) {
        PackageManager packageManager = getPackageManager();
        Intent intent = packageManager.getLeanbackLaunchIntentForPackage(packageName);

        if (intent == null) {
            intent = packageManager.getLaunchIntentForPackage(packageName);
        }

        return tryStartActivity(intent);
    }

    private boolean openUrl(String url) {
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
            return tryStartActivity(intent);
        } catch (Exception e) {
            return false;
        }
    }

    private boolean openSettings() {
        return launchActivityFromAction(Settings.ACTION_SETTINGS);
    }

    private boolean openAppInfo(String packageName) {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                .setData(Uri.fromParts("package", packageName, null));

        return tryStartActivity(intent);
    }

    private boolean uninstallApp(String packageName) {
        Intent intent = new Intent(Intent.ACTION_DELETE)
                .setData(Uri.fromParts("package", packageName, null));

        return tryStartActivity(intent);
    }

    private boolean checkForGetContentAvailability() {
        List<ResolveInfo> intentActivities = getPackageManager().queryIntentActivities(
                new Intent(Intent.ACTION_GET_CONTENT, null).setTypeAndNormalize("image/*"),
                0);

        return !intentActivities.isEmpty();
    }

    private boolean isDefaultLauncher() {
        Intent intent = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME);
        ResolveInfo defaultLauncher = getPackageManager().resolveActivity(intent, 0);

        if (defaultLauncher != null && defaultLauncher.activityInfo != null) {
            return defaultLauncher.activityInfo.packageName.equals(getPackageName());
        }

        return false;
    }

    private boolean startAmbientMode() {
        Intent intent = new Intent(Intent.ACTION_MAIN)
                .setClassName("com.android.systemui", "com.android.systemui.Somnambulator");

        return tryStartActivity(intent);
    }

    private Map<String, Object> getActiveNetworkInformation() {
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                return NetworkUtils.getNetworkInformation(this, connectivityManager.getActiveNetwork());
            } else {
                // noinspection deprecation
                return NetworkUtils.getNetworkInformation(this, connectivityManager.getActiveNetworkInfo());
            }
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> map = new java.util.HashMap<>();
            map.put(NetworkUtils.KEY_NETWORK_TYPE, NetworkUtils.NETWORK_TYPE_UNKNOWN);
            map.put(NetworkUtils.KEY_NETWORK_ACCESS, false);
            map.put(NetworkUtils.KEY_INTERNET_ACCESS, false);
            map.put(NetworkUtils.KEY_WIRELESS_SIGNAL_LEVEL, 0);
            return map;
        }
    }

    private boolean tryStartActivity(Intent intent) {
        boolean success = true;

        try {
            startActivity(intent);
        } catch (Exception ignored) {
            success = false;
        }

        return success;
    }

    private byte[] drawableToByteArray(Drawable drawable) {
        if (drawable.getIntrinsicWidth() <= 0 || drawable.getIntrinsicHeight() <= 0) {
            return new byte[0];
        }

        Bitmap bitmap;
        if (drawable instanceof BitmapDrawable bitmapDrawable) {
            bitmap = bitmapDrawable.getBitmap();
        } else {
            bitmap = drawableToBitmap(drawable);
        }
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        return stream.toByteArray();
    }

    Bitmap drawableToBitmap(Drawable drawable) {
        Bitmap bitmap = Bitmap.createBitmap(
                drawable.getIntrinsicWidth(),
                drawable.getIntrinsicHeight(),
                Bitmap.Config.ARGB_8888);

        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);
        return bitmap;
    }

    private int getActiveNetworkTransportType() {
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
            if (connectivityManager == null) return -1;
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                android.net.Network activeNetwork = connectivityManager.getActiveNetwork();
                if (activeNetwork != null) {
                    NetworkCapabilities capabilities = connectivityManager.getNetworkCapabilities(activeNetwork);
                    if (capabilities != null) {
                        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                            return ConnectivityManager.TYPE_WIFI;
                        } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
                            return ConnectivityManager.TYPE_MOBILE;
                        } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
                            return ConnectivityManager.TYPE_ETHERNET;
                        } else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN)) {
                            return ConnectivityManager.TYPE_VPN;
                        }
                    }
                }
            } else {
                // noinspection deprecation
                android.net.NetworkInfo activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
                if (activeNetworkInfo != null) {
                    return activeNetworkInfo.getType();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    private long getDailyDataUsage() {
        if (!checkUsageStatsPermission()) {
            return -1;
        }

        NetworkStatsManager networkStatsManager = (NetworkStatsManager) getSystemService(Context.NETWORK_STATS_SERVICE);
        if (networkStatsManager == null)
            return 0;



        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
        calendar.set(java.util.Calendar.MINUTE, 0);
        calendar.set(java.util.Calendar.SECOND, 0);
        calendar.set(java.util.Calendar.MILLISECOND, 0);
        long startTime = calendar.getTimeInMillis();
        long endTime = System.currentTimeMillis();

        long totalBytes = 0;
        try {
            NetworkStats.Bucket wifiBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_WIFI,
                    null,
                    startTime,
                    endTime);
            if (wifiBucket != null) {
                totalBytes += wifiBucket.getRxBytes() + wifiBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket mobileBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_MOBILE,
                    null,
                    startTime,
                    endTime);
            if (mobileBucket != null) {
                totalBytes += mobileBucket.getRxBytes() + mobileBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket ethernetBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_ETHERNET,
                    null,
                    startTime,
                    endTime);
            if (ethernetBucket != null) {
                totalBytes += ethernetBucket.getRxBytes() + ethernetBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalBytes;
    }

    private long getWeeklyDataUsage() {
        if (!checkUsageStatsPermission()) {
            return -1;
        }

        NetworkStatsManager networkStatsManager = (NetworkStatsManager) getSystemService(Context.NETWORK_STATS_SERVICE);
        if (networkStatsManager == null)
            return 0;



        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.set(java.util.Calendar.DAY_OF_WEEK, calendar.getFirstDayOfWeek());
        calendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
        calendar.set(java.util.Calendar.MINUTE, 0);
        calendar.set(java.util.Calendar.SECOND, 0);
        calendar.set(java.util.Calendar.MILLISECOND, 0);
        long startTime = calendar.getTimeInMillis();
        long endTime = System.currentTimeMillis();

        long totalBytes = 0;
        try {
            NetworkStats.Bucket wifiBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_WIFI,
                    null,
                    startTime,
                    endTime);
            if (wifiBucket != null) {
                totalBytes += wifiBucket.getRxBytes() + wifiBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket mobileBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_MOBILE,
                    null,
                    startTime,
                    endTime);
            if (mobileBucket != null) {
                totalBytes += mobileBucket.getRxBytes() + mobileBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket ethernetBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_ETHERNET,
                    null,
                    startTime,
                    endTime);
            if (ethernetBucket != null) {
                totalBytes += ethernetBucket.getRxBytes() + ethernetBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalBytes;
    }

    private long getMonthlyDataUsage() {
        if (!checkUsageStatsPermission()) {
            return -1;
        }

        NetworkStatsManager networkStatsManager = (NetworkStatsManager) getSystemService(Context.NETWORK_STATS_SERVICE);
        if (networkStatsManager == null)
            return 0;



        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.set(java.util.Calendar.DAY_OF_MONTH, 1);
        calendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
        calendar.set(java.util.Calendar.MINUTE, 0);
        calendar.set(java.util.Calendar.SECOND, 0);
        calendar.set(java.util.Calendar.MILLISECOND, 0);
        long startTime = calendar.getTimeInMillis();
        long endTime = System.currentTimeMillis();

        long totalBytes = 0;
        try {
            NetworkStats.Bucket wifiBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_WIFI,
                    null,
                    startTime,
                    endTime);
            if (wifiBucket != null) {
                totalBytes += wifiBucket.getRxBytes() + wifiBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket mobileBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_MOBILE,
                    null,
                    startTime,
                    endTime);
            if (mobileBucket != null) {
                totalBytes += mobileBucket.getRxBytes() + mobileBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            NetworkStats.Bucket ethernetBucket = networkStatsManager.querySummaryForDevice(
                    ConnectivityManager.TYPE_ETHERNET,
                    null,
                    startTime,
                    endTime);
            if (ethernetBucket != null) {
                totalBytes += ethernetBucket.getRxBytes() + ethernetBucket.getTxBytes();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalBytes;
    }

    private boolean checkUsageStatsPermission() {
        AppOpsManager appOps = (AppOpsManager) getSystemService(Context.APP_OPS_SERVICE);
        int mode;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            mode = appOps.unsafeCheckOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS,
                    android.os.Process.myUid(), getPackageName());
        } else {
            mode = appOps.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS,
                    android.os.Process.myUid(), getPackageName());
        }

        if (mode == AppOpsManager.MODE_ALLOWED) {
            return true;
        }

        if (mode == AppOpsManager.MODE_DEFAULT) {
            try {
                NetworkStatsManager networkStatsManager = (NetworkStatsManager) getSystemService(Context.NETWORK_STATS_SERVICE);
                if (networkStatsManager != null) {
                    long now = System.currentTimeMillis();
                    networkStatsManager.querySummaryForDevice(ConnectivityManager.TYPE_WIFI, null, now - 1, now);
                    return true;
                }
            } catch (SecurityException e) {
                return false;
            } catch (Exception e) {
                return true;
            }
        }

        return false;
    }

    private void requestUsageStatsPermission() {
        Intent intent = new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);
        tryStartActivity(intent);
    }

    private boolean checkWriteSettingsPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return Settings.System.canWrite(this);
        }
        return true;
    }

    private boolean requestWriteSettingsPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS,
                        Uri.parse("package:" + getPackageName()));
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                if (tryStartActivity(intent)) {
                    return true;
                }
            } catch (Exception ignored) {}
            try {
                Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                if (tryStartActivity(intent)) {
                    return true;
                }
            } catch (Exception ignored) {}
            try {
                Intent intent = new Intent(Settings.ACTION_SETTINGS);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                return tryStartActivity(intent);
            } catch (Exception ignored) {}
            return false;
        }
        return true;
    }

    private boolean setSystemBrightness(int brightness) {
        if (checkWriteSettingsPermission()) {
            try {
                android.content.ContentResolver resolver = getContentResolver();
                // 1. Standard Android brightness
                Settings.System.putInt(resolver, Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL);
                Settings.System.putInt(resolver, Settings.System.SCREEN_BRIGHTNESS, brightness);
                
                // 2. Try common TV "Backlight" keys (Vendor specific)
                Settings.System.putInt(resolver, "backlight", brightness);
                Settings.System.putInt(resolver, "backlight_level", brightness);
                
                return true;
            } catch (Exception e) {
                // Ignore errors on specific keys as they may not exist
                return true; 
            }
        }
        return false;
    }

    private boolean openDefaultLauncherSettings() {
        // 1. Try Android TV home settings
        Intent homeIntent = new Intent(Settings.ACTION_HOME_SETTINGS);
        if (tryStartActivity(homeIntent)) {
            return true;
        }

        // 2. Try manage default apps settings
        Intent defaultAppsIntent = new Intent(Settings.ACTION_MANAGE_DEFAULT_APPS_SETTINGS);
        if (tryStartActivity(defaultAppsIntent)) {
            return true;
        }

        // 3. Fallback to main settings
        return launchActivityFromAction(Settings.ACTION_SETTINGS);
    }

    private boolean openWifiSettings() {
        // 1. Try Android Q+ WiFi panel
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            Intent panelIntent = new Intent(Settings.Panel.ACTION_WIFI);
            if (tryStartActivity(panelIntent)) {
                return true;
            }
        }

        // 2. Try standard WiFi settings
        Intent wifiIntent = new Intent(Settings.ACTION_WIFI_SETTINGS);
        if (tryStartActivity(wifiIntent)) {
            return true;
        }

        // 3. Fallback to general wireless settings
        Intent wirelessIntent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);
        if (tryStartActivity(wirelessIntent)) {
            return true;
        }

        // 4. Final fallback - open main settings
        return launchActivityFromAction(Settings.ACTION_SETTINGS);
    }

    private boolean openVpnSettings() {
        // 1. Try standard VPN settings
        Intent vpnIntent = new Intent(Settings.ACTION_VPN_SETTINGS);
        if (tryStartActivity(vpnIntent)) {
            return true;
        }

        // 2. Fallback to general wireless settings
        Intent wirelessIntent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);
        if (tryStartActivity(wirelessIntent)) {
            return true;
        }

        // 3. Final fallback - open main settings
        return launchActivityFromAction(Settings.ACTION_SETTINGS);
    }

    private boolean openScreensaverSettings() {
        // 1. Try Android TV specific screensaver settings (DaydreamActivity - from
        // Aerial Views)
        Intent tvIntent = new Intent(Intent.ACTION_MAIN);
        tvIntent.setClassName("com.android.tv.settings",
                "com.android.tv.settings.device.display.daydream.DaydreamActivity");
        if (tryStartActivity(tvIntent)) {
            return true;
        }

        // 2. Try standard Android screensaver/dream settings
        Intent dreamIntent = new Intent(Settings.ACTION_DREAM_SETTINGS);
        if (tryStartActivity(dreamIntent)) {
            return true;
        }

        // 3. FALLBACK: Try Display Settings (often contains screensaver on newer
        // Android TV/Google TV)
        Intent displayIntent = new Intent(Settings.ACTION_DISPLAY_SETTINGS);
        if (tryStartActivity(displayIntent)) {
            return true;
        }

        // 4. Final fallback - open main settings
        return launchActivityFromAction(Settings.ACTION_SETTINGS);
    }

    private List<Map<String, Object>> getTvInputs() {
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            TvInputManager manager = (TvInputManager) getSystemService(Context.TV_INPUT_SERVICE);
            if (manager != null) {
                List<TvInputInfo> inputs = manager.getTvInputList();
                for (TvInputInfo input : inputs) {
                    if (input.isPassthroughInput()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("id", input.getId());
                        CharSequence label = input.loadLabel(this);
                        map.put("label", label != null ? label.toString() : input.getId());
                        map.put("type", input.getType());
                        result.add(map);
                    }
                }
            }
        } catch (Exception e) {
            // TIF might not be supported or initialized on emulator
        }
        return result;
    }

    private boolean launchTvInput(String inputId) {
        try {
            Uri uri = TvContract.buildChannelUriForPassthroughInput(inputId);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(uri);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            return tryStartActivity(intent);
        } catch (Exception e) {
            return false;
        }
    }

    private boolean checkNotificationListenerPermission() {
        String packageName = getPackageName();
        String flat = Settings.Secure.getString(getContentResolver(), "enabled_notification_listeners");
        if (flat != null) {
            String[] names = flat.split(":");
            for (String name : names) {
                ComponentName cn = ComponentName.unflattenFromString(name);
                if (cn != null && cn.getPackageName().equals(packageName)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean requestNotificationListenerPermission() {
        try {
            Intent intent = new Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS");
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                Intent intent = new Intent(Settings.ACTION_SETTINGS);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);
                return true;
            } catch (Exception ex) {
                ex.printStackTrace();
                return false;
            }
        }
    }

    private List<Map<String, Object>> getActiveNotifications() {
        List<Map<String, Object>> list = new ArrayList<>();
        LauncherNotificationListenerService service = LauncherNotificationListenerService.getInstance();
        if (service == null) {
            return list;
        }
        try {
            StatusBarNotification[] sbns = service.getActiveNotifications();
            if (sbns != null) {
                for (StatusBarNotification sbn : sbns) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("key", sbn.getKey());
                    map.put("packageName", sbn.getPackageName());
                    
                    android.app.Notification notification = sbn.getNotification();
                    String title = "";
                    String text = "";
                    if (notification != null && notification.extras != null) {
                        CharSequence titleChar = notification.extras.getCharSequence(android.app.Notification.EXTRA_TITLE);
                        CharSequence textChar = notification.extras.getCharSequence(android.app.Notification.EXTRA_TEXT);
                        if (titleChar != null) title = titleChar.toString();
                        if (textChar != null) text = textChar.toString();
                    }
                    map.put("title", title);
                    map.put("text", text);
                    map.put("isClearable", sbn.isClearable());
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private boolean dismissNotification(String key) {
        LauncherNotificationListenerService service = LauncherNotificationListenerService.getInstance();
        if (service == null || key == null) {
            return false;
        }
        try {
            service.cancelNotification(key);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean dismissAllNotifications() {
        LauncherNotificationListenerService service = LauncherNotificationListenerService.getInstance();
        if (service == null) {
            return false;
        }
        try {
            service.cancelAllNotifications();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean checkOverlayPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return Settings.canDrawOverlays(this);
        }
        return true;
    }

    private boolean requestOverlayPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:" + getPackageName()));
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);
                return true;
            } catch (Exception e) {
                try {
                    Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                    return true;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    return false;
                }
            }
        }
        return true;
    }

    private static String cursorStringOrEmpty(android.database.Cursor cursor, String column) {
        String val = cursor.getString(cursor.getColumnIndexOrThrow(column));
        return val != null ? val : "";
    }

    private List<Map<String, Object>> getWatchNextPrograms() {
        List<Map<String, Object>> list = new ArrayList<>();

        String[] projection = {
            TvContract.WatchNextPrograms._ID,
            TvContract.WatchNextPrograms.COLUMN_PACKAGE_NAME,
            TvContract.WatchNextPrograms.COLUMN_TITLE,
            TvContract.WatchNextPrograms.COLUMN_SHORT_DESCRIPTION,
            TvContract.WatchNextPrograms.COLUMN_WATCH_NEXT_TYPE,
            TvContract.WatchNextPrograms.COLUMN_LAST_ENGAGEMENT_TIME_UTC_MILLIS,
            TvContract.WatchNextPrograms.COLUMN_LAST_PLAYBACK_POSITION_MILLIS,
            TvContract.WatchNextPrograms.COLUMN_DURATION_MILLIS,
            TvContract.WatchNextPrograms.COLUMN_INTENT_URI,
            TvContract.WatchNextPrograms.COLUMN_POSTER_ART_URI
        };

        try (android.database.Cursor cursor = getContentResolver().query(
                TvContract.WatchNextPrograms.CONTENT_URI,
                projection,
                null,
                null,
                TvContract.WatchNextPrograms.COLUMN_LAST_ENGAGEMENT_TIME_UTC_MILLIS + " DESC")) {

            if (cursor == null) {
                return list;
            }

            final int limit = 20;
            int row = 0;
            while (row < limit && cursor.moveToNext()) {
                row++;

                Map<String, Object> map = new HashMap<>();
                map.put("id", cursor.getLong(cursor.getColumnIndexOrThrow(TvContract.WatchNextPrograms._ID)));
                map.put("packageName", cursorStringOrEmpty(cursor, TvContract.WatchNextPrograms.COLUMN_PACKAGE_NAME));
                map.put("title", cursorStringOrEmpty(cursor, TvContract.WatchNextPrograms.COLUMN_TITLE));
                map.put("description", cursorStringOrEmpty(cursor, TvContract.WatchNextPrograms.COLUMN_SHORT_DESCRIPTION));
                map.put("watchNextType", cursor.getInt(cursor.getColumnIndexOrThrow(TvContract.WatchNextPrograms.COLUMN_WATCH_NEXT_TYPE)));
                map.put("lastEngagementTime", cursor.getLong(cursor.getColumnIndexOrThrow(TvContract.WatchNextPrograms.COLUMN_LAST_ENGAGEMENT_TIME_UTC_MILLIS)));
                map.put("playbackPosition", cursor.getLong(cursor.getColumnIndexOrThrow(TvContract.WatchNextPrograms.COLUMN_LAST_PLAYBACK_POSITION_MILLIS)));
                map.put("duration", cursor.getLong(cursor.getColumnIndexOrThrow(TvContract.WatchNextPrograms.COLUMN_DURATION_MILLIS)));
                map.put("intentUri", cursorStringOrEmpty(cursor, TvContract.WatchNextPrograms.COLUMN_INTENT_URI));
                map.put("posterArtUri", cursorStringOrEmpty(cursor, TvContract.WatchNextPrograms.COLUMN_POSTER_ART_URI));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private byte[] getWatchNextPoster(String posterArtUri) {
        if (posterArtUri == null || posterArtUri.isEmpty()) {
            return null;
        }
        try {
            Uri uri = Uri.parse(posterArtUri);
            try (java.io.InputStream inputStream = getContentResolver().openInputStream(uri)) {
                if (inputStream != null) {
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    return outputStream.toByteArray();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean launchWatchNextProgram(String intentUri) {
        if (intentUri == null || intentUri.isEmpty()) {
            return false;
        }
        // Security: only allow safe URI schemes
        String lower = intentUri.toLowerCase();
        if (!lower.startsWith("intent://") && !lower.startsWith("https://") &&
            !lower.startsWith("http://") && !lower.startsWith("content://")) {
            return false;
        }
        try {
            Intent intent = Intent.parseUri(intentUri, Intent.URI_INTENT_SCHEME);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean isAccessibilityServiceEnabled() {
        String service = getPackageName() + "/" + LauncherAccessibilityService.class.getName();
        int accessibilityEnabled = 0;
        try {
            accessibilityEnabled = Settings.Secure.getInt(
                getContentResolver(),
                Settings.Secure.ACCESSIBILITY_ENABLED
            );
        } catch (Settings.SettingNotFoundException e) {
            e.printStackTrace();
        }

        if (accessibilityEnabled == 1) {
            String settingValue = Settings.Secure.getString(
                getContentResolver(),
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            );
            if (settingValue != null) {
                String[] services = settingValue.split(":");
                for (String s : services) {
                    if (s.equalsIgnoreCase(service)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean openAccessibilitySettings() {
        try {
            Intent intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            if (tryStartActivity(intent)) {
                return true;
            }
        } catch (Exception ignored) {}
        try {
            Intent intent = new Intent(Settings.ACTION_SETTINGS);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            return tryStartActivity(intent);
        } catch (Exception ignored) {}
        return false;
    }

    private boolean checkWatchNextPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return checkSelfPermission("com.android.providers.tv.permission.READ_WRITE_WATCH_NEXT_PROGRAMS") == PackageManager.PERMISSION_GRANTED
                || checkSelfPermission("android.permission.READ_TV_LISTINGS") == PackageManager.PERMISSION_GRANTED;
        }
        return true;
    }



    private String getLatestWeatherData() {
        android.content.SharedPreferences prefs = getSharedPreferences(WeatherReceiver.PREFS_NAME, Context.MODE_PRIVATE);
        return prefs.getString(WeatherReceiver.KEY_WEATHER_JSON, null);
    }

    private boolean isBreezyWeatherInstalled() {
        try {
            getPackageManager().getPackageInfo("org.breezyweather", 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    private boolean openBreezyWeather() {
        try {
            Intent launchIntent = getPackageManager().getLaunchIntentForPackage("org.breezyweather");
            if (launchIntent != null) {
                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(launchIntent);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 1002) {
            if (pendingPermissionResult != null) {
                boolean granted = grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED;
                pendingPermissionResult.success(granted);
                pendingPermissionResult = null;
            }
        }
    }
}
