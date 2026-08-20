import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// The Play UPLOAD key. Not the app signing key: Play App Signing holds that
// one, and it is the reason losing this file is recoverable through Play
// support rather than fatal.
//
// Two sources, in order. `android/key.properties` is git-ignored and is how a
// local release build finds the keystore. The environment is how CI does it,
// out of GitHub Actions secrets, which are encrypted and not exposed to fork
// pull requests. This repository is public: neither the keystore nor its
// password may ever be a file inside it.
val keyProperties = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}

fun signingMaterial(property: String, variable: String): String? =
    keyProperties.getProperty(property) ?: System.getenv(variable)

val uploadStorePath = signingMaterial("storeFile", "ANDROID_KEYSTORE_PATH")
val uploadStorePassword = signingMaterial("storePassword", "ANDROID_KEYSTORE_PASSWORD")
val uploadKeyAlias = signingMaterial("keyAlias", "ANDROID_KEY_ALIAS")
val uploadKeyPassword = signingMaterial("keyPassword", "ANDROID_KEY_PASSWORD")
val canSignRelease = listOf(
    uploadStorePath,
    uploadStorePassword,
    uploadKeyAlias,
    uploadKeyPassword,
).all { !it.isNullOrBlank() } && file(uploadStorePath!!).exists()

android {
    namespace = "com.spencerfields.littlebird"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.spencerfields.littlebird"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (canSignRelease) {
            create("upload") {
                storeFile = file(uploadStorePath!!)
                storePassword = uploadStorePassword
                keyAlias = uploadKeyAlias
                keyPassword = uploadKeyPassword
            }
        }
    }

    buildTypes {
        release {
            // Null when there is no key, and deliberately not a fall back to
            // the debug one. A release bundle signed with the debug key builds
            // without complaint, uploads, and is refused by Play with a
            // message about the certificate -- which reads like a Play fault
            // and sends you looking in the wrong place. An unsigned bundle is
            // refused too, but for the reason that is actually true.
            signingConfig = signingConfigs.findByName("upload")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// Said at configuration time rather than discovered at upload time. Without
// this the only symptom is a bundle Play will not take, hours later.
gradle.taskGraph.whenReady {
    if (allTasks.any { it.name.contains("Release") } && !canSignRelease) {
        logger.warn("")
        logger.warn("  Wren: building RELEASE with no upload key.")
        logger.warn("  The output will be unsigned and Play will refuse it.")
        logger.warn("  Put storeFile, storePassword, keyAlias and keyPassword")
        logger.warn("  in android/key.properties, or set ANDROID_KEYSTORE_PATH,")
        logger.warn("  ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS and")
        logger.warn("  ANDROID_KEY_PASSWORD in the environment.")
        logger.warn("")
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Chrome Custom Tabs. Needed for the Google Maps route: My Maps has no
    // Android app and no import API, so the only way in is its web page — and a
    // Custom Tab is the one surface that is BOTH signed in (it is Chrome, so it
    // carries the session the user already has) and permitted to sign in. An
    // embedded WebView can inject script but Google blocks Google sign-in inside
    // one; a Custom Tab can sign in but forbids injection. That split is
    // deliberate, and it is why this is a tab rather than a WebView.
    implementation("androidx.browser:browser:1.8.0")
}
