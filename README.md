# react-native-download-manager

## Getting started

`$ npm install react-native-download-manager --save`

### Mostly automatic installation

`$ react-native link react-native-download-manager`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-download-manager` and add `LKDownloadManager.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libLKDownloadManager.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import lightkits.downloadmanager.LKDownloadManagerPackage;` to the imports at the top of the file
  - Add `new LKDownloadManagerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-download-manager'
  	project(':react-native-download-manager').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-download-manager/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-download-manager')
  	```


## Usage
```javascript
import LKDownloadManager from 'react-native-download-manager';

// TODO: What to do with the module?
LKDownloadManager;
```

## Create module command
create-react-native-module download-manager --prefix LK --package-identifier lightkits.downloadmanager
