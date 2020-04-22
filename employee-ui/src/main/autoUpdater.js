// autoUpdater.js
import {autoUpdater} from "electron-updater";

export default callback => {
    autoUpdater.on("checking-for-update", () => {
        callback("正在检查更新");
    });

    autoUpdater.on("update-available", info => {
        callback("发现新版本");
    });

    autoUpdater.on("update-not-available", info => {
        callback("没有可用更新");
    });

    autoUpdater.on("error", err => {
        callback("更新出现错误");
    });

    autoUpdater.on("update-downloaded", info => {
        callback("下载完成");

        // 收到渲染进程发来的`updateNow`命令时, 立即重启安装更新
        ipcMain.on("updateNow", (e, arg) => {
            autoUpdater.quitAndInstall();
        });

        // 向渲染进程发送请求, 确认是否立即安装
        main.webContents.send("updateNow");
    });

    autoUpdater.on("download-progress", progress => {
        const speed = (progress.bytesPerSecond / 1000).toFixed(2);
        const downloaded = progress.percent.toFixed(2);
        const transferByte = Math.ceil(progress.transferred / 1000);
        const totalByte = Math.ceil(progress.total / 1000);

        let msg =
            `下载速度: ${speed} KB` +
            `已下载 ${downloaded}% - (${transferByte} / ${totalByte})`;

        callback(msg);
    });

    return autoUpdater;
};