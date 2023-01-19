flutter clean
flutter pub get
#flutter build web

# build to github pages
flutter build web --release --base-href="/checkerAppBuild/"

rm -r release
mkdir "release"
cp -R build/web release
rm -r build
