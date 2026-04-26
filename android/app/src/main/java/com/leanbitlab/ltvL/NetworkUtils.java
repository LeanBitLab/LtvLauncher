package com.leanbitlab.ltvL;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.TelephonyNetworkSpecifier;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.telephony.TelephonyManager;

import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class NetworkUtils
{
    // Aligned with NetworkType enum value indices, on file lib/providers/network_service.dart
    public static final int NETWORK_TYPE_CELLULAR = 0;
    public static final int NETWORK_TYPE_WIFI = 1;
    public static final int NETWORK_TYPE_VPN = 2;
    public static final int NETWORK_TYPE_WIRED = 3;
    public static final int NETWORK_TYPE_UNKNOWN = 4;

    public static final String KEY_INTERNET_ACCESS = "internetAccess";
    public static final String KEY_NETWORK_ACCESS = "networkAccess";
    public static final String KEY_NETWORK_TYPE = "networkType";
    public static final String KEY_WIRELESS_SIGNAL_LEVEL = "wirelessSignalLevel";

    public static Map<String, Object> getNetworkCapabilitiesInformation(Context context, NetworkCapabilities capabilities)
    {
        boolean hasNetworkAccess, hasInternetAccess;
        int wirelessNetworkSignalLevel = 0;
        int networkType = NETWORK_TYPE_UNKNOWN;

        hasNetworkAccess = capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            hasInternetAccess = capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED);
        }
        else {
            hasInternetAccess = hasNetworkAccess;
        }

        if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)) {
            networkType = NETWORK_TYPE_CELLULAR;
        }
        else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
            WifiManager wifiManager = (WifiManager) context
                    .getApplicationContext().getSystemService(Context.WIFI_SERVICE);

            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q
                    && capabilities.getTransportInfo() instanceof WifiInfo) {
                WifiInfo wifiInfo = (WifiInfo) capabilities.getTransportInfo();
                wirelessNetworkSignalLevel = getWifiSignalLevel(wifiInfo);
            }
            else {
                // TODO: Will this give the correct information?
                try {
                    if (wifiManager != null) {
                        WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                        if (wifiInfo != null) {
                            wirelessNetworkSignalLevel = getWifiSignalLevel(wifiInfo);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            networkType = NETWORK_TYPE_WIFI;
        }
        else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_VPN)) {
            networkType = NETWORK_TYPE_VPN;
        }
        else if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)) {
            networkType = NETWORK_TYPE_WIRED;
        }

        Map<String, Object> map = new java.util.HashMap<>();
        map.put(KEY_NETWORK_ACCESS, hasNetworkAccess);
        map.put(KEY_INTERNET_ACCESS, hasInternetAccess);
        map.put(KEY_NETWORK_TYPE, networkType);
        map.put(KEY_WIRELESS_SIGNAL_LEVEL, wirelessNetworkSignalLevel);
        return map;
    }

    public static Map<String, Object> getNetworkInformation(Context context, Network network)
    {
        Map<String, Object> map = null;
        int wirelessNetworkSignalLevel = 0;

        if (network != null) {
            ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkCapabilities capabilities = connectivityManager.getNetworkCapabilities(network);

            if (capabilities != null) {
                map = getNetworkCapabilitiesInformation(context, capabilities);

                if (Objects.equals(map.get(KEY_NETWORK_TYPE), NETWORK_TYPE_WIFI)) {
                    try {
                        WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
                        if (wifiManager != null) {
                            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                            if (wifiInfo != null) {
                                wirelessNetworkSignalLevel = getWifiSignalLevel(wifiInfo);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        if (map != null) {
            map = new HashMap<>(map);
        }
        else {
            map = new HashMap<>();
            map.put(KEY_NETWORK_TYPE, NETWORK_TYPE_UNKNOWN);
            map.put(KEY_NETWORK_ACCESS, false);
            map.put(KEY_INTERNET_ACCESS, false);
        }

        map.put(KEY_WIRELESS_SIGNAL_LEVEL, wirelessNetworkSignalLevel);

        return map;
    }

    public static Map<String, Object> getNetworkInformation(Context context, @Nullable NetworkInfo networkInfo)
    {
        boolean hasNetworkAccess = false;
        int networkType = NETWORK_TYPE_UNKNOWN, networkInfoType, wirelessSignalLevel = 0;

        if (networkInfo != null) {
            hasNetworkAccess = networkInfo.isConnected();
            networkInfoType = networkInfo.getType();

            if (networkInfoType == ConnectivityManager.TYPE_MOBILE) {
                networkType = NETWORK_TYPE_CELLULAR;
            }
            if (networkInfoType == ConnectivityManager.TYPE_WIFI) {
                WifiManager wifiManager = (WifiManager) context
                        .getApplicationContext().getSystemService(Context.WIFI_SERVICE);

                networkType = NETWORK_TYPE_WIFI;
                try {
                    if (wifiManager != null) {
                        WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                        if (wifiInfo != null) {
                            wirelessSignalLevel = getWifiSignalLevel(wifiInfo);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else if (networkInfoType == ConnectivityManager.TYPE_VPN) {
                networkType = NETWORK_TYPE_VPN;
            }
            else if (networkInfoType == ConnectivityManager.TYPE_ETHERNET) {
                networkType = NETWORK_TYPE_WIRED;
            }
        }

        Map<String, Object> mapOut = new java.util.HashMap<>();
        mapOut.put(KEY_NETWORK_TYPE, networkType);
        mapOut.put(KEY_NETWORK_ACCESS, hasNetworkAccess);
        mapOut.put(KEY_INTERNET_ACCESS, hasNetworkAccess);
        mapOut.put(KEY_WIRELESS_SIGNAL_LEVEL, wirelessSignalLevel);
        return mapOut;
    }

    public static int getWifiSignalLevel(WifiInfo wifiInfo)
    {
        final int SIGNAL_LEVELS = 4;
        int rssi = wifiInfo.getRssi();

        return calculateSignalLevel(rssi, SIGNAL_LEVELS);
    }

    private static final int MIN_RSSI = -90;
    private static final int MAX_RSSI = -55;
    public static int calculateSignalLevel(int rssi, int levels)
    {
        if (rssi <= MIN_RSSI) {
            return 0;
        } else if (rssi >= MAX_RSSI) {
            return levels - 1;
        } else {
            final float inputRange = (MAX_RSSI - MIN_RSSI);
            final float outputRange = (levels - 1);
            return (int)((float)(rssi - MIN_RSSI) * outputRange / inputRange);
        }
    }
}
