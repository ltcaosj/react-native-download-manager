import {NativeModules} from 'react-native';

const {LKDownloadManager} = NativeModules;

const downloadFile = async (url, destPath) => {
  const filePath = await LKDownloadManager.download(url, destPath);
  return `${filePath}`;
};

export {LKDownloadManager, downloadFile};
