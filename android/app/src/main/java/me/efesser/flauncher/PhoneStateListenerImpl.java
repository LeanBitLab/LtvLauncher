package me.efesser.flauncher;

import android.telephony.PhoneStateListener;

import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class PhoneStateListenerImpl extends PhoneStateListener
{
    private final EventChannel.EventSink _eventSink;

    public  PhoneStateListenerImpl(EventChannel.EventSink eventSink)
    {
        _eventSink = eventSink;
    }

    @Override
    public void onDataConnectionStateChanged(int state, int networkType)
    {
        _eventSink.success(new java.util.HashMap<String, Object>() {{ put("name", "CELLULAR_STATE_CHANGED"); put("arguments", networkType); }});
    }
}
