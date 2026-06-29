package com.steel.xuseragent

import android.content.pm.PackageManager
import android.os.Build
import XUserAgentApi
import NativeUserAgentData
import android.content.Context
import android.webkit.WebSettings
import io.flutter.embedding.engine.plugins.FlutterPlugin

class XUserAgentPlugin : FlutterPlugin, XUserAgentApi {
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        XUserAgentApi.setUp(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        XUserAgentApi.setUp(binding.binaryMessenger, null)
    }

    override fun getWebViewUserAgent(callback: (Result<String?>) -> Unit) {
        val userAgent = runCatching {
            WebSettings.getDefaultUserAgent(applicationContext)
        }.getOrNull() ?: System.getProperty("http.agent")

        callback(Result.success(userAgent))
    }

    override fun getSystemUserAgent(callback: (Result<String?>) -> Unit) {
        callback(Result.success(System.getProperty("http.agent")))
    }

    override fun getUserAgentData(callback: (Result<NativeUserAgentData?>) -> Unit) {
        val packageManager = applicationContext.packageManager
        val packageName = applicationContext.packageName
        val packageInfo = packageManager.getPackageInfoCompat(packageName)
        val appName = packageManager.getApplicationLabel(
            applicationContext.applicationInfo
        ).toString()

        callback(
            Result.success(
                NativeUserAgentData(
                    platform = "Android",
                    platformVersion = Build.VERSION.RELEASE,
                    model = Build.MODEL,
                    architecture = Build.SUPPORTED_ABIS.firstOrNull(),
                    appName = appName,
                    appVersion = packageInfo?.versionName,
                    buildNumber = packageInfo?.longVersionCodeCompat()?.toString(),
                    packageName = packageName,
                    mobile = true,
                    device = Build.DEVICE,
                    brand = Build.BRAND,
                    isEmulator = isProbablyEmulator(),
                    darwinVersion = null,
                    cfnetworkVersion = null,
                )
            ),
        )
    }

    private fun isProbablyEmulator(): Boolean {
        return Build.FINGERPRINT.startsWith("generic") ||
            Build.FINGERPRINT.contains("emulator", ignoreCase = true) ||
            Build.MODEL.contains("Emulator", ignoreCase = true) ||
            Build.MODEL.contains("Android SDK built for", ignoreCase = true) ||
            Build.MANUFACTURER.contains("Genymotion", ignoreCase = true) ||
            Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic") ||
            "google_sdk" == Build.PRODUCT
    }
}

private fun PackageManager.getPackageInfoCompat(packageName: String) = runCatching {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        getPackageInfo(packageName, PackageManager.PackageInfoFlags.of(0))
    } else {
        @Suppress("DEPRECATION")
        getPackageInfo(packageName, 0)
    }
}.getOrNull()

private fun android.content.pm.PackageInfo.longVersionCodeCompat(): Long {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        longVersionCode
    } else {
        @Suppress("DEPRECATION")
        versionCode.toLong()
    }
}
