package com.leanbitlab.ltvL;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

/**
 * Starts the launcher after boot when the "Start on boot" setting is on. Meant for devices whose
 * stock launcher always wins HOME resolution (Google TV, Fire TV). Android 10+ only allows this
 * background activity start while the app holds an exemption, e.g. the Home Button Fix
 * accessibility service is enabled or the overlay permission is granted; otherwise it is dropped.
 */
public class BootReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        if (!Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) return;
        // shared_preferences stores Flutter keys in this file with a "flutter." prefix.
        boolean enabled = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                .getBoolean("flutter.start_on_boot", false);
        if (!enabled) return;
        context.startActivity(new Intent(context, MainActivity.class).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK));
    }
}
