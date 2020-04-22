import {
    app,
    BrowserWindow,
    globalShortcut,
    ipcMain,
    screen
} from 'electron'

const {
    autoUpdater
} = require('electron-updater')
import Update from './update'

/**
 * Set `__static` path to static files in production
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-static-assets.html
 */
if (process.env.NODE_ENV !== 'development') {
    global.__static = require('path').join(__dirname, '/static').replace(/\\/g, '\\\\')
}
const ipc = ipcMain
let mainWindow
let onlineStatusWindow

//此方法的返回值表示你的应用程序实例是否成功取得了锁。 如果它取得锁失败，你可以假设另一个应用实例已经取得了锁并且仍旧在运行，并立即退出。
const gotTheLock = app.requestSingleInstanceLock()

const winURL = process.env.NODE_ENV === 'development' ?
    `http://localhost:9080` :
    `file://${__dirname}/index.html`
//设置只能运行一个exe
if (!gotTheLock) {
    app.quit()
} else {
    app.on('second-instance', (event, commandLine, workingDirectory) => {
        // 当运行第二个实例时,将会聚焦到myWindow这个窗口
        if (mainWindow) {
            if (mainWindow.isMinimized()) mainWindow.restore()
            mainWindow.focus()
        }
    })
}

function createWindow() {

    /**
     * Initial window options
     */
    mainWindow = new BrowserWindow({
        show: false,
        useContentSize: true,
        frame: false,
        //获取屏幕高度，因为默认是600px
        height: screen.getPrimaryDisplay().workAreaSize.height,
        backgroundColor: '#0876FE'
    })
    mainWindow.loadURL(winURL)

    mainWindow.once('ready-to-show', () => {
        mainWindow.show()
    })
    let update = new Update(mainWindow)

    // mainWindow.on('ready-to-show', function () {
    //     mainWindow.show() // 初始化后再显示
    //   })
    //去掉菜单
    mainWindow.setMenu(null)
    //debugger模式,上线正式环境去掉
    //mainWindow.webContents.openDevTools()
    mainWindow.maximize()


    // mainWindow.show()


    //处理更新操作
    function handleUpdate() {
        const returnData = {
            error: {
                status: -1,
                msg: '检测更新查询异常'
            },
            checking: {
                status: 0,
                msg: '正在检查应用程序更新'
            },
            updateAva: {
                status: 1,
                msg: '检测到新版本，正在下载,请稍后'
            },
            updateNotAva: {
                status: -1,
                msg: '您现在使用的版本为最新版本,无需更新!'
            },
        };

        //package.json配置一样，客户端更新的url
        autoUpdater.setFeedURL('http://129.211.23.xxx/update/');

        //更新错误
        autoUpdater.on('error', function (error) {
            sendUpdateMessage(returnData.error)
        });

        //检查中
        autoUpdater.on('checking-for-update', function () {
            //sendUpdateMessage(returnData.checking)
        });

        //发现新版本
        autoUpdater.on('update-available', function (info) {
            sendUpdateMessage(returnData.updateAva)
        });

        //当前版本为最新版本
        autoUpdater.on('update-not-available', function (info) {
            //不给提示
            // setTimeout(function () {
            //     sendUpdateMessage(returnData.updateNotAva)
            // }, 1000);
        });

        // 更新下载进度事件
        autoUpdater.on('download-progress', function (progressObj) {
            // console.log(BrowserWindow.getFocusedWindow())
            // const winId = BrowserWindow.getFocusedWindow().id;
            // let win = BrowserWindow.fromId(winId);
            mainWindow.webContents.send('downloadProgress', progressObj)
        });
        //注意:：严格来说不需要处理此事件。即时成功下载之后，下一次应用程序启动时，仍将继续下载更新文件。
        autoUpdater.on('update-downloaded', () => {
            sendUpdateMessage("即将安装，请稍等")
            autoUpdater.quitAndInstall()
        });

        //执行自动更新检查
        // autoUpdater.checkForUpdates();
    }

    handleUpdate();

    // 通过main进程发送事件给renderer进程，提示更新信息
    function sendUpdateMessage(text) {
        mainWindow.webContents.send('message', text)
    }

    ipcMain.on("checkForUpdate", (event, data) => {
        console.log('执行自动更新检查!!!');
        // event.sender.send('reply', 'hi lee my name is yuan, age is 17');
        autoUpdater.checkForUpdates();
    });

}



app.on('ready', () => {
    createWindow();
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit()
    }
})

app.on('activate', () => {
    if (mainWindow === null) {
        createWindow()
    }
})
//窗口最小化
ipc.on('min', function () {
    mainWindow.minimize();
})
//窗口最大化
ipc.on('max', function () {
    if (mainWindow.isMaximized()) {
        mainWindow.restore();
    } else {
        mainWindow.maximize();
    }
})
//窗口关闭
ipc.on('close', function () {
    mainWindow.close();
})
//检测是否联网
app.whenReady().then(() => {
    onlineStatusWindow = new BrowserWindow({
        show: false,
        useContentSize: true,
        frame: false,
        height: height,
        backgroundColor: '#0876FE'
    })
    onlineStatusWindow.loadURL(winURL)
})
ipcMain.on('online-status-changed', (event, status) => {
    console.log(status)
})
/**
 * Auto Updater
 *
 * Uncomment the following code below and install `electron-updater` to
 * support auto updating. Code Signing with a valid certificate is required.
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-electron-builder.html#auto-updating
 */

/*
import { autoUpdater } from 'electron-updater'

autoUpdater.on('update-downloaded', () => {
  autoUpdater.quitAndInstall()
})

app.on('ready', () => {
  if (process.env.NODE_ENV === 'production') autoUpdater.checkForUpdates()
})
 */