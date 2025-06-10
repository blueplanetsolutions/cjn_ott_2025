#!/bin/bash

# Step 1: Close any running instances of Android Studio or related build processes
echo "Stopping any running Android Studio or Gradle processes..."
pkill -f 'gradle|studio'

# Step 2: Clear Gradle Cache
echo "Clearing Gradle cache..."
rm -rf ~/.gradle/caches/

# Step 3: Delete Gradle Build Folder
echo "Deleting the android/build directory..."
if [ -d "android/build" ]; then
    rm -rf android/build
else
    echo "No android/build directory found."
fi

# Step 4: Clean Flutter Project
echo "Cleaning Flutter project..."
flutter clean
flutter pub get
cd packages
cd chewie
flutter clean
flutter pub get
cd ..
cd vimeo
flutter clean
flutter pub get
cd ..
cd ..

# Step 5: Refresh Gradle Dependencies
echo "Refreshing Gradle dependencies..."
cd android
./gradlew --refresh-dependencies

# Step 6: Run Gradle Clean
echo "Cleaning Gradle project..."
./gradlew clean
cd ..

# Step 7: Rebuild the Flutter Project
# echo "Rebuilding Flutter project..."
# flutter build apk --release

echo "Build process completed!"
