import {NativeModules} from 'react-native';

const {LKDownloadManager} = NativeModules;

const downloadFile = async (url, destPath) => {
  const filePath = await LKDownloadManager.download(url, destPath);
  return `${filePath}`;
};

const clearCacheDirectory = async (directory) => {
  return  LKDownloadManager.clearCacheDirectory(directory);  
};

const deleteFile = async (destPath) => {
  const filePath = await LKDownloadManager.deleteFile(destPath);
  return `${filePath}`;
};



export {LKDownloadManager, downloadFile, clearCacheDirectory, deleteFile};
