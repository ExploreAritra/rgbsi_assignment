package com.rgbsi.assignment
import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

enum class BluetoothAction {
    TurnOn,
    TurnOff
}

class MainActivity: FlutterActivity() {

    private val methodChannel = "assignment/bluetooth"
    private val eventChannel = "assignment/bluetoothStatus"
    private var events: EventChannel.EventSink? = null
    private lateinit var bluetoothManager: BluetoothManager
    private lateinit var bluetoothAdapter: BluetoothAdapter
    private val myPermissionCode = 1452
    private var permissionGranted: Boolean = false
    private var activeResult: MethodChannel.Result? = null
    private var currentAction: BluetoothAction? = null


    private fun initPermissions(result: MethodChannel.Result, action: BluetoothAction) {
        activeResult = result
        currentAction = action
        checkPermissions(application)
    }

    private fun arePermissionsGranted(application: Context) {
        val permissions = mutableListOf(
            Manifest.permission.BLUETOOTH,
            Manifest.permission.BLUETOOTH_ADMIN,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION
        )
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            permissions.add(Manifest.permission.BLUETOOTH_CONNECT)
            permissions.add(Manifest.permission.BLUETOOTH_SCAN)
        }

        for (perm in permissions) {
            permissionGranted = ContextCompat.checkSelfPermission(application, perm) == PackageManager.PERMISSION_GRANTED
        }
    }

    private fun checkPermissions(application: Context,) {
        arePermissionsGranted(application)
        if (!permissionGranted) {
            Log.i("permission_check", "permissions not granted, asking")
            val permissions = mutableListOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_ADMIN,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
            )
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                permissions.add(Manifest.permission.BLUETOOTH_CONNECT)
                permissions.add(Manifest.permission.BLUETOOTH_SCAN)
            }
            ActivityCompat.requestPermissions(activity, permissions.toTypedArray(), myPermissionCode)
        } else {
            Log.i("permission_check", "permissions granted, continuing")
            completeCheckPermissions()
        }
    }

    private fun completeCheckPermissions() {
        if ( permissionGranted ) {
            if(currentAction == BluetoothAction.TurnOn) {
                Log.i("Bluetooth", "Turning on bluetooth")
                turnOnBluetooth()
            } else if(currentAction == BluetoothAction.TurnOff) {
                Log.i("Bluetooth", "Turning off bluetooth")
                turnOffBluetooth()
            }
            Log.i("Bluetooth", "Doing nothing")
        } else {
            Log.i("Bluetooth", "Permission Not Granted!")
            activeResult?.error("permissions_not_granted", "if permissions are not granted, you will not be able to use this plugin", null)
        }
    }


    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == myPermissionCode) {
            permissionGranted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
            if(permissionGranted) {
                Log.i("Bluetooth", "Permission Granted!")
                completeCheckPermissions()
            } else {
                Log.i("Bluetooth", "Permission was NOT Granted!")
                activeResult?.let { currentAction?.let { it1 -> initPermissions(it, it1) } }
            }

        } else {
            Log.i("Bluetooth", "Permission not granted.")
        }
    }

    private fun turnOnBluetooth() {
        if (!bluetoothAdapter.isEnabled) {
            // Bluetooth is disabled
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            if (ActivityCompat.checkSelfPermission(
                    this,
                    Manifest.permission.BLUETOOTH_CONNECT
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                startActivityForResult(enableBtIntent, myPermissionCode)
            } else {
                checkPermissions(application)
            }
        } else {
            activeResult?.success(true)
        }
    }

    private fun turnOffBluetooth() {
        if (bluetoothAdapter.isEnabled) {
            // Turn Bluetooth off
            if (ActivityCompat.checkSelfPermission(
                    this,
                    Manifest.permission.BLUETOOTH_CONNECT
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                bluetoothAdapter.disable()
                Log.i("Bluetooth", "Bluetooth turned off")
            } else {
                checkPermissions(application)
            }
            // Log Bluetooth status

        } else {
            // Bluetooth is already off, nothing to do
            activeResult?.success(true)

        }
    }

    private val receiver = object : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            when(intent.action) {
                BluetoothAdapter.ACTION_STATE_CHANGED -> {

                    when (intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, -1)) {
                        BluetoothAdapter.STATE_ON -> {
                            events?.success("Bluetooth turned on")
                            Log.i("Bluetooth", "Bluetooth turned on")
                        }
                        BluetoothAdapter.STATE_OFF -> {
                            events?.success("Bluetooth turned off")
                            Log.i("Bluetooth", "Bluetooth turned off")
                        }
                    }
                }
            }
        }

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        bluetoothAdapter = bluetoothManager.adapter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannel).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "turnOnBluetooth" -> {
                    initPermissions(result, BluetoothAction.TurnOn)
                }
                "turnOffBluetooth" -> {
                    initPermissions(result, BluetoothAction.TurnOff)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }


        EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannel).setStreamHandler(object :
            EventChannel.StreamHandler {
            // Called when stream is listened from Flutter
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                registerReceiver(receiver, IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED))
                this@MainActivity.events = events
                events.success(if(bluetoothAdapter.isEnabled) "Bluetooth turned on" else "Bluetooth turned off")
            }

            // Called when stream is cancelled by Flutter
            override fun onCancel(arguments: Any?) {
                events?.endOfStream()
            }
        })
    }

}
