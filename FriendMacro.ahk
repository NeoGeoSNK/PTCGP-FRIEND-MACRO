/************************************************************************
 * @description PtcgP FriendMacro by GaloXDoido
 * @author GaloXDoido (Original Code by Banana-juseyo)
 * @date 2025/02/04
 * @version 1.10
 * @see {@link https://github.com/GaloXDoido/PtcgP-FriendMacro-GaloXDoido Github Repository of this version}
 * @see {@link https://github.com/banana-juseyo/Banana-Macro-PtcgP Github Repository of Original Code}
 ***********************************************************************/

; Original code by Banana-juseyo
; Translated and adapted by GaloXDoido
; Recommended screen resolution: 1920 * 1080
; Recommended emulator: mumuplayer
; Recommended instance resolution: 540 * 960 (220 dpi)

global _appTitle := "PtcgP FriendMacro"
global _author := "GaloXDoido (Original Code by Banana-juseyo)"
global _currentVersion := "v1.10"
global _website := "https://github.com/banana-juseyo/Banana-Macro-PtcgP"
global _websiteBR := "https://github.com/GaloXDoido/PtcgP-FriendMacro-GaloXDoido"
global _repoName := "Banana-Macro-PtcgP"

#Requires AutoHotkey v2.0
#Include .\app\WebView2.ahk
#include .\app\_JXON.ahk
#Include .\app\Gdip_All.ahk  ; Ensure this is the v2-compatible version

;; Caminhos de Arquivos
global _imageFile_friendRequestListCard := A_ScriptDir . "\asset\match\friendRequestListCard.png"
global _imageFile_friendAdd := A_ScriptDir . "\asset\match\friendAdd.png"
global _imageFile_friendSearch := A_ScriptDir . "\asset\match\friendSearch.png"
global _imageFile_sendRequest := A_ScriptDir . "\asset\match\sendRequest.png"
global _imageFile_friendRequestListEmpty := A_ScriptDir . "\asset\match\friendRequestListEmpty.png"
global _imageFile_friendRequestListClearButton := A_ScriptDir . "\asset\match\friendRequestListClearButton.png"
global _imageFile_userDetailEmblem := A_ScriptDir . "\asset\match\userDetailEmblem.png"
global _imageFile_userDetailMybest := A_ScriptDir . "\asset\match\userDetailMybest.png"
global _imageFile_passportPikachu := A_ScriptDir . "\asset\match\passportPikachu.png"
global _imageFile_userDetailAccept := A_ScriptDir . "\asset\match\userDetailAccept.png"
global _imageFile_userDetailDecline := A_ScriptDir . "\asset\match\userDetailDecline.png"
global _imageFile_userDetailRequestFriend := A_ScriptDir . "\asset\match\userDetailRequestFriend.png"
global _imageFile_userDetailFriendNow := A_ScriptDir . "\asset\match\userDetailFriendNow.png"
global _imageFile_userDetailEmpty := A_ScriptDir . "\asset\match\userDetailEmpty.png"
global _imageFile_userDetailRequestNotFound := A_ScriptDir . "\asset\match\userDetailRequestNotFound.png"
global _imageFile_friendMenuButton := A_ScriptDir . "\asset\match\friendsMenuButton.png"
global _imageFile_friendListCard := A_ScriptDir . "\asset\match\friendListCard.png"
global _imageFile_friendListEmpty := A_ScriptDir . "\asset\match\friendListEmpty.png"
global _imageFile_friendCountEmpty := A_ScriptDir . "\asset\match\friendCountEmpty.png"
global _imageFile_friendCount1 := A_ScriptDir . "\asset\match\friendCount1.png"
global _imageFile_removeFriendConfirm := A_ScriptDir . "\asset\match\removeFriendConfirm.png"
global _imageFile_removeFriendConfirmSpanish := A_ScriptDir . "\asset\match\removeFriendConfirmSpanish.png"
global _imageFile_appIcon := A_ScriptDir . "\asset\image\_app_Icon.png"
global _imageFile_close := A_ScriptDir . "\asset\image\_app_Close.png"
global _imageFile_restart := A_ScriptDir . "\asset\image\_app_Restart.png"
global _localeFolderPath := A_ScriptDir . "\asset\locales\"

; Variáveis Globais
global _isRunning := FALSE
global _isPausing := FALSE
global _debug := FALSE
global messageQueue := []
global _downloaderGUIHwnd := ""
global _configGUIHwnd := ""
global GuiInstance := {}
global recentText := ""
global RecentTextCtrl := {}
global oldTexts := ""
global _userIni := {}
global _userLocale := {}
global _currentLocale := {}
global FileInfo

; Inicialização dos valores do ambiente e valores padrão.
global _delayConfig := 150
global _instanceNameConfig := ""
global _acceptingTermConfig := 8 * 60000
global _deletingTermConfig := 2 * 60000
global _localeConfig := ""

; Definindo caminho do arquivo de log
global logFile := A_ScriptDir . "\log\" . A_YYYY . A_MM . A_DD . "_" . A_Hour . A_Min . A_Sec . "_" . "log.txt"

DownloaderInstance := Downloader()
;; msedge.dll 파일 확인
; DownloaderInstance.CheckMsedgeDLL()
    updateScriptPath := A_Temp "\updater.ahk"
    if FileExist(updateScriptPath)
FileDelete(updateScriptPath)
    ; DownloaderInstance.CheckForUpdates()

    class Downloader {
gui := ""
         ProgressBar := {}
TextCtrl := {}
Http := {}
_progress := 0

               __New() {
                   if (_downloaderGUIHwnd && WinExist(_downloaderGUIHwnd)) {
                       WinActivate(_downloaderGUIHwnd)
                           this.gui := GuiFromHwnd(_downloaderGUIHwnd)
                   }
               }

           ; Inicio dos processos relacionados à GUI
               OpenDownloaderGUI() {
                   global _downloaderGUIHwnd
                       global ProgressBar, TextCtrl

                       _gui := GUI()
                       _downloaderGUIHwnd := _gui.hwnd
                       _gui.Opt("-SysMenu -Caption")
                       _gui.Title := "Automatic update"

                       TextCtrl := _gui.Add("Text", "x10 y10 w300", "Checking file status...")
                       ProgressBar := _gui.Add("Progress", "x10 y40 w300 h20")

                       _gui.Show()
                       this.gui := _gui
                       return _gui
               }

           Dismiss() {
               if (WinActive(_downloaderGUIHwnd)) {
                   This.gui.Destroy()
                       return
               }
           }

           CheckMsedgeDLL() {
_msedgeProjectPath := "/app/msedge.dll"
                        _fullpath := A_ScriptDir . _msedgeProjectPath

                        if (FileExist(_fullpath) && FileGetSize(_fullpath) >= 283108904) {
                            SendDebugMsg("No update needed")
                        } else {
FileInfo := DownloaderInstance.GetRepoApi(_msedgeProjectPath)
              if (FileInfo["isAvailable"]) {
d := DownloaderInstance.Download(FileInfo, _fullpath)
              } else {
                  MsgBox(_currentLocale.UpdateInsertError)
              }
          if (d) {
              if (WinActive(DownloaderInstance.gui.hwnd)) {
                  DownloaderInstance.gui.Destroy()
              }
          }
          else {
              MsgBox(_currentLocale.UpdateDownloadError)
          }
                        }
           }

           Download(FileInfo, _fullPath) {
               global TextCtrl
                   global _progress

                   url := FileInfo["downloadUrl"]
                   fileName := FileInfo["fileName"]
                   destination := FileInfo["destination"]
                   size := FileInfo["size"]

                   DownloaderInstance.OpenDownloaderGUI()

                   if FileExist(_fullPath) {
                       FileDelete(_fullPath)
                   }
               try {
                   TextCtrl.Text := "Download : " fileName
                       SetTimer(() => This.UpdateDownloadProgress(_fullPath, size), 100)
                       Download(url, _fullPath)

                       if (FileGetSize(_fullPath) >= size) {
                           global TextCtrl
                               TextCtrl.Text := ("Download Complete")
                               Sleep(1000)
                               return TRUE
                       }
                   return TRUE
               }
               catch Error as e {
                   MsgBox _currentLocale.DownloadGeneralError . "" . e.Message
                       Reload
               }
           }

           UpdateDownloadProgress(_fullPath, _fullSize) {
               global ProgressBar, _progress
                   try {
_currentSize := FileGetSize(_fullPath)
                  _progress := Floor((_currentSize / _fullSize) * 100)

                  ProgressBar.Value := _progress

                  if (_currentSize >= _fullSize) {
_progress := 100
               SetTimer , 0
               return
                  }
                   }
               catch Error as e {
                   MsgBox ( "[UpdateDownloadProgress]An error occurred during file download: " . "" . e.Message)
                       Reload
               }
           }

           ; Repo Api에서 파일 조회 -> obj
               GetRepoApi(ProjectFilePath) {
i := InStr(ProjectFilePath, "/", , -1)
       Path := SubStr(ProjectFilePath, 1, i - 1)
       FileName := SubStr(ProjectFilePath, i + 1)
       if (ProjectFilePath == "/app/msedge.dll") {
url := "https://api.github.com/repos/banana-juseyo/Banana-Macro-PtcgP/contents/app/msedge.dll"
         try {
http := ComObject("WinHttp.WinHttpRequest.5.1")
          http.Open("GET", url, TRUE)
          http.Send()
          http.WaitForResponse()
          response := http.ResponseText
          ; responsStr := Jxon_Dump(response)
          responseMap := Jxon_Load(&response)
          if (responseMap["name"] == "msedge.dll") {
              return Map(
                      "isAvailable", TRUE,
                      "fileName", responseMap["name"],
                      "destination", A_ScriptDir . Path . "/",
                      "fullPath", A_ScriptDir . Path . "/" . responseMap["name"],
                      "downloadUrl", responseMap["download_url"],
                      "size", responseMap["size"]
                      )
          } else {
              return Map("isAvailable", FALSE)
          }
         }
     catch Error as e {
         MsgBox _currentLocale.FileVerificationError . "" . e.Message
             return Map("isAvailable", false)
     }
       } else {
url := "https://api.github.com/repos/banana-juseyo/" . _repoName . "/contents" . Path
         try {
http := ComObject("WinHttp.WinHttpRequest.5.1")
          http.Open("GET", url, TRUE)
          http.Send()
          http.WaitForResponse()
          response := http.ResponseText
          ; responsStr := Jxon_Dump(response)
          responseMap := Jxon_Load(&response)
          for key, file in responseMap {
              if (file["name"] = FileName) {
                  return Map(
                          "isAvailable", TRUE,
                          "fileName", FileName,
                          "destination", A_ScriptDir . Path . "/",
                          "fullPath", A_ScriptDir . Path . "/" . FileName,
                          "downloadUrl", file["download_url"],
                          "size", file["size"]
                          )
              }
          }
      return Map("isAvailable", FALSE)
         }
     catch Error as e {
         MsgBox _currentLocale.FilePackageVerificationError . "" . e.Message
             return Map("isAvailable", false)
     }
       }
               }

           ; Verificar a versão mais recente do script
               CheckForUpdates() {
url := "https://api.github.com/repos/GaloXDoido/PtcgP-FriendMacro-GaloXDoido/releases/latest"
         try {
http := ComObject("WinHttp.WinHttpRequest.5.1")
          http.Open("GET", url, true)
          http.Send()
          http.WaitForResponse()
          response := http.ResponseText
          response := Jxon_Load(&response)
          latestVersion := response["tag_name"]
          if (latestVersion != _currentVersion) {
              ; Caso seja necessário atualizar
                  fileInfo := Map(
                          "isAvailable", TRUE,
                          "fileName", response["assets"][1]["name"],
                          "destination", tempFile := A_Temp,
                          "fullPath", tempFile := A_Temp "\" A_ScriptName ".new",
                          "downloadUrl", response["assets"][1]["browser_download_url"],
                          "size", response["assets"][1]["size"]
                          )
                  return this.PerformUpdate(fileInfo)
          }
      ; Caso não seja necessário atualizar
          return true
         }
     catch Error as e {
         MsgBox _currentLocale.UpdateVerificationError . "" . e.Message
             return false
     }
               }

           ; Executar atualização
               PerformUpdate(FileInfo) {
downloadUrl := FileInfo["downloadUrl"]
                 try {
_fullpath := FileInfo["fullPath"]
               FileAppend("", _fullpath)
               backupFile := A_ScriptFullPath ".backup"
               ; Baixar nova versão
               ; Download(downloadUrl, tempFile)
               d := DownloaderInstance.Download(FileInfo, _fullpath)
               ; Fazer backup do script atual
               if FileExist(backupFile)
                   FileDelete(backupFile)
                       FileCopy(A_ScriptFullPath, backupFile)
                       ; Criar arquivo de script de atualização
                       updateScriptPath := this.CreateUpdateScript(_fullpath)
                       ; Encerrar o script atual após executar o script de atualização
                       Run(updateScriptPath)
                       ExitApp

                       return true
                 }
             catch Error as e {
                 MsgBox _currentLocale.UpdateInstallError . "" . e.Message
                     return false
             }
               }

           CreateUpdateScript(tempFile) {
               ; Gerar um novo script de atualização AHK para realizar a atualização externamente
                   updateScript := '#Requires AutoHotkey v2.0`n'
                   updateScript .= 'Sleep(2000)`n'
                   updateScript .= 'originalFile := "' A_ScriptFullPath '"`n'
                   updateScript .= 'newFile := "' tempFile '"`n'
                   updateScript .= '`n'
                   updateScript .= 'try {`n'
                       updateScript .= 'if FileExist(originalFile)`n'
                           updateScript .= 'FileDelete(originalFile)`n'
                           updateScript .= 'FileMove(newFile, originalFile)`n'
                           updateScript .= 'Run(originalFile)`n'
                           updateScript .= '} Catch Error as e {`n'
                               updateScript .= 'MsgBox("Update error: " . "" . e.Message)`n'
                                   updateScript .= '}`n'
                                   updateScript .= 'ExitApp'

                                   ; Gerar arquivo temporário do script de atualização
                                   updateScriptPath := A_Temp "\updater.ahk"
                                   if FileExist(updateScriptPath)
                                       FileDelete(updateScriptPath)

                                           FileAppend(updateScript, updateScriptPath)
                                           return updateScriptPath
           }
    }

;; Definir a interface principal (UI)
d := 1.25
width := Round(560 * d)
height := Round(432 * d)
radius := Round(8 * d)

ui := Gui("-SysMenu -Caption +LastFound")
ui.OnEvent('Close', (*) => ExitApp())

    hIcon := LoadPicture(".\asset\image\app.ico", "Icon1 w" 32 " h" 32, &imgtype)
SendMessage(0x0080, 1, hIcon, ui)
    ui.Show("w560 h432")
    _instanceWindow := WinGetID(A_ScriptName, , "Code",)
    WinSetTitle _appTitle . " " . _currentVersion, _instanceWindow
    WinSetRegion Format("0-0 w{1} h{2} r{3}-{3}", width, height, radius), _instanceWindow

    ;; Criar a interface principal (WebView2)
    wvc := WebView2.CreateControllerAsync(ui.Hwnd, { AdditionalBrowserArguments: "--enable-features=msWebView2EnableDraggableRegions" })
.await2()
    wv := wvc.CoreWebView2
    nwr := wv.NewWindowRequested(NewWindowRequestedHandler)
    uiHtmlPath := A_ScriptDir . "\asset\html\index.html"
    wv.Navigate("file:///" . StrReplace(uiHtmlPath, "\", "/"))

    NewWindowRequestedHandler(wv2, arg) {
deferral := arg.GetDeferral()
              arg.NewWindow := wv2
              deferral.Complete()
    }

UpdateHtmlVersion(_currentVersion)

    ;; Listener para verificar os valores vindos da interface principal (UI) -> Não é executado quando passado como função dentro de um loop (problema de prioridade)
    nwr := wv.WebMessageReceived(HandleWebMessageReceived)
    HandleWebMessageReceived(sender, args) {
        global _isPausing, _configGUIHwnd, GuiInstance

            message := args.TryGetWebMessageAsString()
            switch message {
                case "_button_click_header_home":
                    Run _website
                        return
                case "_button_click_header_traducao":
                        Run _websiteBR
                            return
                case "_button_click_header_restart":
                            FinishRun()
                                Reload
                                return
                case "_button_click_header_quit":
                                ExitApp
                                    return
                case "_button_click_footer_start":
                                    SetTimer(() => StartRun("00"), -1)
                                        return
                case "_button_click_footer_start_wo_deleting":
                                        _acceptingTermConfig := 90000000000000
                                            IniWrite 90000000000000, "Settings.ini", "UserSettings", "AcceptingTerm"
                                            SetTimer(() => StartRun("00"), -1)
                                            return
                case "_button_click_footer_clear_friends":
                                            SetTimer(() => StartRun("D00"), -1)
                                                return
                case "_button_click_footer_pause":
                                                TogglePauseMode()
                                                    Pause -1
                                                    if (_isPausing) {
                                                        SendUiMsg("⏸️" . _currentLocale.PauseButton)
                                                    }
                                                    else if ( NOT _isPausing) {
                                                        SendUiMsg("▶️" . _currentLocale.ContinueButton)
                                                    }
                                                return
                case "_button_click_footer_stop":
                                                    FinishRun()
                                                        return
                case "_button_click_footer_settings":
                                                        GuiInstance := ConfigGUI()
                                                            return
                case "_click_github_link":
                                                            Run _website
                                                                return
                case "_click_github_link_traducao":
                                                                Run _websiteBR
                                                                    return
            }
    }

;; Início da lógica relacionada às configurações
; Carregar configurações
_userIni := ReadUserIni()
_userLocale := ReadUserLocale(_userIni.Locale)

; Classe personalizada para GUI de configurações
class ConfigGUI {
gui := ""

         __New() {
             if (_configGUIHwnd && WinExist(_configGUIHwnd)) {
                 WinActivate(_configGUIHwnd)
                     this.gui := GuiFromHwnd(_configGUIHwnd)
             }
             else {
                 this.gui := OpenConfigGUI()
             }
         }

     Submit() {
         global _userIni
             _userIni := this.gui.Submit(TRUE)
             UpdateUserIni(_userIni)
             this.gui.Destroy()
             return
     }

     Dismiss() {
         if (WinActive(_configGUIHwnd)) {
             this.gui.Destroy()
                 return
         }
     }
}

;; 환경값 재설정
_delayConfig := _userIni.Delay
_instanceNameConfig := _userIni.InstanceName
_acceptingTermConfig := _userIni.AcceptingTerm * 60000
_deletingTermConfig := _userIni.BufferTerm * 60000
_localeConfig := _userIni.Locale

; 환경설정 GUI 정의
OpenConfigGUI() {
    global _configGUIHwnd

        _gui := GUI()
        _configGUIHwnd := _gui.hwnd
        _gui.Opt("-SysMenu +LastFound +Owner" ui.Hwnd)
        _gui.Title := _currentLocale.EnvironmentConfig
        _gui.BackColor := "DADCDE"
        _defaultValue := ""

        section := { x1: 30, y1: 30 }
_confInstanceNameTitle := _gui.Add("Text", Format("x{} y{} w100 h30", section.x1, section.y1 + 5),
                                _currentLocale.InstanceName)
                            _confInstanceNameTitle.SetFont("q3  s10 w600")
                            _redDotText := _gui.Add("Text", Format("x{} y{} w10 h30", section.x1 + 93, section.y1 + 3),
                                    "*")
                            _redDotText.SetFont("q3 s11 w600 cF65E3C")
                            _confInstanceNameField := _gui.Add("Edit", Format("x{} y{} w280 h26 -VScroll Background", section.x1 +
                                        120,
                                        section.y1), _userIni.InstanceName)
                            _confInstanceNameField.SetFont("q3  s13")
                            _confInstanceNameField.name := "InstanceName"
                            _confInstanceNameHint := _gui.Add("Text", Format("x{} y{} w280 h24", section.x1 + 120, section.y1 + 36),
                                    _currentLocale.InstanceNameDesc)
                            _confInstanceNameHint.SetFont("q3  s8 c636363")

                            switch _userIni.Delay {
                                global _defaultValue
                                case "150": _defaultValue := "Choose1"
                                case "250": _defaultValue := "Choose2"
                                case "350": _defaultValue := "Choose3"
                            }
section := { x1: 30, y1: 100, default: _defaultValue }
_confDelayTitle := _gui.Add("Text", Format("x{} y{} w100 h30", section.x1, section.y1 + 5), _currentLocale.DelayMs
                         )
                     _confDelayTitle.SetFont("q3 s10 w600")
                     _confDelayField := _gui.Add("DropDownList", Format("x{} y{} w280 {}", section.x1 + 120,
                                 section.y1, section.default), [150, 250, 350])
                     _confDelayField.SetFont("q3  s13")
                     _confDelayField.name := "Delay"
                     _confDelayHint := _gui.Add("Text", Format("x{} y{} w280 h24", section.x1 + 120, section.y1 + 30),
                             _currentLocale.DelayMsDesc)
                     _confDelayHint.SetFont("q3  s8 c636363")

                     switch _userIni.AcceptingTerm {
                         global _defaultValue
                         case 6: _defaultValue := "Choose1"
                         case 8: _defaultValue := "Choose2"
                         case 10: _defaultValue := "Choose3"
                         case 12: _defaultValue := "Choose4"
                     }
section := { x1: 30, y1: 170, default: _defaultValue }
_confAcceptingTermTitle := _gui.Add("Text", Format("x{} y{} w100 h30", section.x1, section.y1 + 5),
                                 _currentLocale.AcceptingTerm)
                             _confAcceptingTermTitle.SetFont("q3  s10 w600")
                             _confAcceptingTermField := _gui.Add("DropDownList", Format("x{} y{} w280 {}", section.x1 + 120,
                                         section.y1, section.default), [6, 8, 10, 12])
                             _confAcceptingTermField.SetFont("q3  s13")
                             _confAcceptingTermField.name := "AcceptingTerm"
                             _confAcceptingTermHint := _gui.Add("Text", Format("x{} y{} w280 h24", section.x1 + 120, section.y1 + 30
                                         ),
                                     _currentLocale.AcceptingTermDesc)
                             _confAcceptingTermHint.SetFont("q3  s8 c636363")

                             switch _userIni.BufferTerm {
                                 global _defaultValue
                                 case 2: _defaultValue := "Choose1"
                                 case 3: _defaultValue := "Choose2"
                                 case 4: _defaultValue := "Choose3"
                             }
section := { x1: 30, y1: 240, default: _defaultValue }
_confBufferTermTitle := _gui.Add("Text", Format("x{} y{} w100 h30", section.x1, section.y1 + 5),
                              _currentLocale.DeletingWaitTime)
                          _confBufferTermTitle.SetFont("q3  s10 w600")
                          _confBufferTermField := _gui.Add("DropDownList", Format("x{} y{} w280 {}", section.x1 + 120, section.y1,
                                      section.default
                                      ), [1, 3, 5])
                          _confBufferTermField.SetFont("q3  s13")
                          _confBufferTermField.name := "BufferTerm"
                          _confBufferTermHint := _gui.Add("Text", Format("x{} y{} w280 h24", section.x1 + 120, section.y1 + 30),
                                  _currentLocale.DeletingWaitTimeDesc)
                          _confBufferTermHint.SetFont("q3  s8 c636363")

                          switch _userIni.Locale {
                              global _defaultValue
                              case "English": _defaultValue := "Choose1"
                              case "Portuguese": _defaultValue := "Choose2"
                              case "Spanish": _defaultValue := "Choose3"
                          }
section := { x1: 30, y1: 310, default: _defaultValue }
_confLocaleTitle := _gui.Add("Text", Format("x{} y{} w100 h30", section.x1, section.y1 + 5),
                          _currentLocale.Language)
                      _confLocaleTitle.SetFont("q3  s10 w600")
                      _confLocaleField := _gui.Add("DropDownList", Format("x{} y{} w280 {}", section.x1 + 120, section.y1,
                                  section.default
                                  ), ["English", "Portuguese", "Spanish"])
                      _confLocaleField.SetFont("q3  s13")
                      _confLocaleField.name := "Locale"
                      _confLocaleHint := _gui.Add("Text", Format("x{} y{} w280 h24", section.x1 + 120, section.y1 + 30),
                              _currentLocale.LanguageDesc)
                      _confLocaleHint.SetFont("q3  s8 c636363")

                      section := { x1: 30, y1: 370 }
_confirmButton := _gui.Add("Button", Format("x{} y{} w120 h40 BackgroundDADCDE", section.x1 + 76,
                            section.y1
                            ), _currentLocale.SaveButton)
                    _confirmButton.SetFont("q3  w600")
                    _confirmButton.OnEvent("Click", Submit)
                    _cancleButton := _gui.Add("Button", Format("x{} y{} w120 h40 BackgroundDADCDE", section.x1 + 200,
                                section.y1
                                ), _currentLocale.CancelButton)
                    _cancleButton.SetFont("q3  w600")
                    _cancleButton.OnEvent("Click", Dismiss)

                    _gui.Show("")
                    _gui.Move(528, 205, 480, 470)

                    return _gui

                    Submit(*) {
                        global _userIni
                            _userIni := _gui.Submit(TRUE)
                            UpdateUserIni(_userIni)
                            _gui.Destroy()
                            Reload
                            return
                    }
                Dismiss(*) {
                    if (WinActive(_gui.Hwnd)) {
                        _gui.Destroy()
                            return
                    }
                }
}

F5:: {
    SetTimer(() => StartRun("00"), -1)
}
F6:: {
    SetTimer(() => StartRun("D00"), -1)
}
F7:: {
    TogglePauseMode()
        Pause -1
        if (_isPausing) {
            SendUiMsg("⏸️" . _currentLocale.PauseButton)
        }
        else if ( NOT _isPausing) {
            SendUiMsg("▶️" . _currentLocale.ContinueButton)
        }
    return
}
F8:: {
    SetTimer(() => FinishRun(), -1)
        Reload
}

^R:: {
    SetTimer(() => FinishRun(), -1)
        Reload
}

#HotIf WinActive(_configGUIHwnd)
~Enter:: {
_gui := GuiFromHwnd(_configGUIHwnd)
          GuiInstance.Submit()
}
~Esc:: {
    GuiInstance.Dismiss()
}

;; Definindo a tela da GUI
global statusGUI := Gui()
statusGUI.Opt("-SysMenu +Caption")
RecentTextCtrl := statusGUI.Add("Text", "x10 y10 w360 h20")
RecentTextCtrl.SetFont("s11", "Segoe UI Emoji, Segoe UI")
OldTextCtrl := statusGUI.Add("Text", "x10 y30 w360 h160")
OldTextCtrl.SetFont("C666666", "Segoe UI Emoji, Segoe UI")
if (_debug == TRUE) {
    statusGUI.Show("")
}


; Function to read user codes from file
ReadUserCodesFromFile(fileName) {
    local userCodes := []
        local filePath := fileName
        if !FileExist(filePath) {
            SendUiMsg("Error: " . filePath . " not found. Please create this file.")
                return userCodes ; Return empty array
        }
    local fileContent := FileRead(filePath)
        userCodes := StrSplit(fileContent, "`n", "`r")
        ; Remove empty lines and trim whitespace
        Loop userCodes.Length {
            userCodes[A_Index] := Trim(userCodes[A_Index])
        }
    ; Filter out empty entries
        filteredCodes := []
        for code in userCodes {
            if (code != "") {
                filteredCodes.Push(code)
            }
        }
    return filteredCodes
}






; Define the OCR function
OCR(area, lang) {
x := area[1]
       y := area[2]
       w := area[3]
       h := area[4]
       pBitmap := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
       ; Use a unique filename with timestamp to avoid overwriting
       timestamp := FormatTime(A_Now, "yyyyMMdd_HHmmss")
       tempFile := "capture_" . timestamp . ".png"
       Gdip_SaveBitmapToFile(pBitmap, tempFile)
       Gdip_DisposeImage(pBitmap)

       ; Run Tesseract on the captured image
       RunWait "tesseract " . tempFile . " output -l " . lang
       T := FileRead("output.txt")

       FileDelete tempFile
       FileDelete "output.txt"
       return T
}


_main(_currentLogic := "00") {


    global _isRunning
        global targetWindowHwnd
        global GuiInstance
        global _instanceNameConfig := _userIni.InstanceName
        global userCodesArray
        global userCodeIndex
        global userCodesCount
        global userDelArray  ; Add global for deletion list
        global userDelIndex
        global userDelCount

        global pToken := Gdip_Startup()  ; Initialize Gdip for OCR useage and store the token

        userCodesArray := ReadUserCodesFromFile("usercodes.txt")  ; For adding friends
        userCodeIndex := 1
        userCodesCount := userCodesArray.Length

        userDelArray := ReadUserCodesFromFile("userdel.txt")      ; For deleting friends
        userDelIndex := 1
        userDelCount := userDelArray.Length

        if (userCodesCount = 0) {
            SendUiMsg("No user codes found in usercodes.txt. Please add user codes to the file.")
        } else {
            SendUiMsg("Found " . userCodesCount . " user codes in usercodes.txt.")
        }
    if (userDelArray.Length = 0) {
        SendUiMsg("No user IDs found in userdel.txt. Deletion will be skipped unless IDs are added.")
    } else {
        SendUiMsg("Found " . userDelArray.Length . " user IDs in userdel.txt for deletion.")
    }


    SetTitleMatchMode 3

        if ( NOT _instanceNameConfig) {
GuiInstance := ConfigGUI()
                 SendUiMsg(_currentLocale.InstanceNameNotInserted)
                 SetTimer(() => FinishRun(), -1)
                 return
        }
    if ( NOT WinExist(_instanceNameConfig)) {
GuiInstance := ConfigGUI()
                 SendUiMsg(_currentLocale.InstanceNameNotFound)
                 SetTimer(() => FinishRun(), -1)
                 return
    }

targetWindowHwnd := WinExist(_instanceNameConfig)
                      if ( NOT targetWindowHwnd) {
                          SendUiMsg(_currentLocale.InstanceNameNotRunningGame . "" . _instanceNameConfig)
                              SetTimer(() => FinishRun(), -1)
                              return
                      }
                      else if targetWindowHwnd {
                          WinGetPos(&targetWindowX, &targetWindowY, &targetWindowWidth, &targetWindowHeight, targetWindowHwnd)
                              global targetControlHandle := ControlGetHwnd('nemuwin1', targetWindowHwnd)
                      }
                  WinMove(, , 527, 970, targetWindowHwnd)
                      WinActivate (targetWindowHwnd)
                      CoordMode("Pixel", "Screen")

                      global targetWindowX, targetWindowY, targetWindowWidth, targetWindowHeight, _thisUserPass, _thisUserFulfilled
                      global _nowAccepting
                      global _recentTick, _currentTick
                      global failCount

                      _isRunning := TRUE
                      _nowAccepting := TRUE
                      _thisUserPass := FALSE
                      _thisUserFulfilled := FALSE
                      _recentTick := A_TickCount
                      _currentTick := A_TickCount

                      loop {
                          if (!_isRunning) {
                              break
                          }

                          WinGetPos(&targetWindowX, &targetWindowY, &targetWindowWidth, &targetWindowHeight, targetWindowHwnd)
                              switch _currentLogic {
                                  ; 00. 화면 초기화
                                  case "00":
                                      ;; 환경값 재설정
                                          _delayConfig := _userIni.Delay
                                          _instanceNameConfig := _userIni.InstanceName
                                          _acceptingTermConfig := _userIni.AcceptingTerm * 60000
                                          _deletingTermConfig := _userIni.BufferTerm * 60000
                                          _localeConfig := _userIni.Locale

                                          SendUiMsg("✅" . _currentLocale.StartFriendAddName)
                                          caseDescription := _currentLocale.StartFriendAddDesc
                                          SendUiMsg("[Current] " . _currentLogic . " : " . caseDescription)
                                          InitLocation("RequestList")
                                          _currentLogic := "000"
                                          static globalRetryCount := 0
                                          failCount := 0

                                  case "000":

                                          if (userCodeIndex <= userCodesCount) {

                                              delayXLong()

                                                  match := ImageSearch(
                                                          &matchedX
                                                          , &matchedY
                                                          , getScreenXbyWindowPercentage('78%')
                                                          , getScreenYbyWindowPercentage('15%')
                                                          , getScreenXbyWindowPercentage('99%')
                                                          , getScreenYbyWindowPercentage('22%')
                                                          , '*50 ' . _imageFile_friendAdd)
                                                  if (match == 1) {
targetX := matchedX - targetWindowX
             targetY := matchedY - targetWindowY
             delayLong()
             ControlClick('X' . targetX . ' Y' . targetY, targetWindowHwnd, , 'Left', 1, 'NA', ,)
             delayXLong()

             ; Attempt to locate the text box via ImageSearch.
             friendSearchFound := ImageSearch(  &textboxX
                     , &textboxY
                     , getScreenXbyWindowPercentage('66%')
                     , getScreenYbyWindowPercentage('72%')
                     , getScreenXbyWindowPercentage('96%')
                     , getScreenYbyWindowPercentage('96%')
                     , "*50 " . _imageFile_friendSearch)

             if (friendSearchFound == 1) {
                 SendUiMsg("Friend search button located!")
                     targetTextX := textboxX - targetWindowX
                     targetTextY := textboxY - targetWindowY

                     currentCode := Trim(userCodesArray[userCodeIndex]) ; Get current user code
                     if (currentCode != "") {
A_Clipboard := currentCode ; Set clipboard to the user code
                 ControlClick("X" . targetTextX - 200 . " Y" . targetTextY, targetWindowHwnd, "", "Left", 1, "NA")
                 delayXLong()
                 Send("^v")  ; Simulate Ctrl+V to paste.
                 delayLong()
                 Send "{Enter}"
                 delayLong()
                 ControlClick("X" . targetTextX . " Y" . targetTextY, targetWindowHwnd, "", "Left", 1, "NA")
                 SendUiMsg("Start searching with code:" A_Clipboard)
                 delayXLong()
                 delayXLong()

                 ; Attempt to send friend request
                 sendRequestFound := ImageSearch(  &sendRequestX
                         , &sendRequestY
                         , getScreenXbyWindowPercentage('58%')
                         , getScreenYbyWindowPercentage('44%')
                         , getScreenXbyWindowPercentage('92%')
                         , getScreenYbyWindowPercentage('50%')
                         , "*50 " . _imageFile_sendRequest)

                 if (sendRequestFound == 1) {
                     SendUiMsg("Send Friend Request located!")
                         targetReqX := sendRequestX - targetWindowX
                         targetReqY := sendRequestY - targetWindowY
                         ControlClick("X" . targetReqX . " Y" . targetReqY, targetWindowHwnd, "", "Left", 1, "NA")
                 } else {
                     SendUiMsg("####Can't find send request button")
                 }

             delayXLong()

                     } else {
                         SendUiMsg("####Warning: Empty user code in usercodes.txt at line " . userCodeIndex . ". Skipping.")
                     }

             } else {
                 SendUiMsg("####Search friend text box not found!")
                     ; You might want to add error handling or a retry mechanism here.
             }

                                                  } else if (match == 0) {
                                                      SendUiMsg("####Can't find add friend icon")
                                                  }

                                              SendUiMsg("Processing user: " . userCodeIndex . " done")
                                                  userCodeIndex++

                                          } else {
                                              SendUiMsg("All user codes processed.")
                                                  FinishRun()
                                                  return
                                          }

                                          InitLocation("FriendList")


                                              ;; Início da lógica de rejeição
                                  case "D00":
                                              static nextUser := 0
                                                  global userIncrement := 182
                                                  ;; Redefinir valores de ambiente
                                                  _delayConfig := _userIni.Delay
                                                  _instanceNameConfig := _userIni.InstanceName
                                                  _acceptingTermConfig := _userIni.AcceptingTerm * 60000
                                                  _deletingTermConfig := _userIni.BufferTerm * 60000
                                                  _localeConfig := _userIni.Locale

                                                  SendUiMsg("🗑️" . _currentLocale.DeletingFriendBegin)
                                                  caseDescription := _currentLocale.GoToFriendDeleteMenu
                                                  SendUiMsg("[Current] " . _currentLogic . " : " . caseDescription)
                                                  failCount := 0
                                                  InitLocation("FriendList")
                                                  delayXLong()
                                                  _currentLogic := "D01"

                                  case "D01":

                                                  if (userDelIndex <= userDelCount) {

caseDescription := _currentLocale.FriendListVerify
                     SendUiMsg("[Current] " . _currentLogic . " : " . caseDescription)
                     delayShort()
                     static globalRetryCount := 0

                     match := ImageSearch(
                             &matchedX,
                             &matchedY,
                             getScreenXbyWindowPercentage('56%'),
                             getScreenYbyWindowPercentage('20%'),
                             getScreenXbyWindowPercentage('98%'),
                             getScreenYbyWindowPercentage('44%'),
                             '*100 ' . _imageFile_friendListCard)
                     delayXLong()
                     if (match == 1) {
globalRetryCount := 0
                      targetX := matchedX - targetWindowX
                      targetY := matchedY - targetWindowY
                      ; Use nextUser to adjust the Y position (default to 0 if not set)
                      ControlClick('X' . targetX . ' Y' . (targetY + 50 + nextUser), targetWindowHwnd, , 'Left', 1, 'NA', ,)
                      delayShort()
                      ControlClick('X' . targetX . ' Y' . (targetY + 50 + nextUser), targetWindowHwnd, , 'Left', 1, 'NA', ,)
                      _currentLogic := "D02"
                      _thisUserDeleted := FALSE
                      failCount := 0
                      delayLong()
                     } else if (match == 0) {
                         SendUiMsg("Checking friend count.")
                             delayXLong()
                             match := ImageSearch(
                                     &matchedX,
                                     &matchedY,
                                     getScreenXbyWindowPercentage('20%'),
                                     getScreenYbyWindowPercentage('5%'),
                                     getScreenXbyWindowPercentage('80%'),
                                     getScreenYbyWindowPercentage('40%'),
                                     '*50 ' . _imageFile_friendCountEmpty)
                             if (match == 1) {
                                 SendUiMsg(_currentLocale.AllFriendsDeleted)
                                     PhaseToggler()
                                     globalRetryCount := 0 
                                     FinishRun() 
                                     return
                             } else if (match == 0) {

                                 SendUiMsg("####Can't get friend list, fail try count: " failCount)
                                     failCount := failCount + 1
                             }
                         if (failCount >= 5) {
globalRetryCount := globalRetryCount + 1
                      if (globalRetryCount > 5) {
                          SendUiMsg(_currentLocale.CriticalFailureExit)
                              ExitApp
                      }
                  SendUiMsg(_currentLocale.RedefiningScreen)
                      failCount := 0
                      nextUser := 0  ; Reset nextUser on failure
                      InitLocation('FriendList')
                         }
                     }

                                                  } else {
                                                      SendUiMsg("All accounts in userdel.txt processed, exit.")
                                                          FinishRun()
                                                          return
                                                  }


                                  case "D02":

                                                  caseDescription := _currentLocale.ScreenFriendEntering
                                                      SendUiMsg("[Current] " . _currentLogic . " : " . caseDescription)
                                                      delayXLong()  ; Increased delay to ensure text renders

                                                      ; Perform OCR to check for text in the user detail area
                                                      ocrX := getScreenXbyWindowPercentage('62%')
                                                      ocrY := getScreenYbyWindowPercentage('9%')
                                                      ocrW := getScreenXbyWindowPercentage('96%') - ocrX
                                                      ocrH := getScreenYbyWindowPercentage('13%') - ocrY
                                                      ocrText := OCR([ocrX, ocrY, ocrW, ocrH], "eng")
                                                      SendUiMsg("OCR capture result: '" . ocrText . "'")
                                                      ocrText := RegExReplace(ocrText, "[^0-9]", "")
                                                      SendUiMsg("OCR extract friend codes result: '" . ocrText . "'")

                                                      global userDelArray
                                                      canDelete := false
                                                      if (ocrText != "") {
                                                          for delId in userDelArray {
                                                              if (InStr(ocrText, delId)) {
canDelete := true
               SendUiMsg("Match found: '" . delId . "' in userdel.txt, proceeding with deletion")
               break
                                                              }
                                                          }
                                                          if (!canDelete) {
                                                              _clickCloseModalButton() 
                                                                  SendUiMsg("No matching ID found in userdel.txt. User: '" . ocrText . "' was kept")
                                                          }
                                                      } else {
                                                          SendUiMsg("OCR returned empty result, not in friend detail page, try to get friend count")
                                                              matchOnly1 := ImageSearch(
                                                                      &matchedX,
                                                                      &matchedY,
                                                                      getScreenXbyWindowPercentage('32%'),
                                                                      getScreenYbyWindowPercentage('6%'),
                                                                      getScreenXbyWindowPercentage('74%'),
                                                                      getScreenYbyWindowPercentage('31%'),
                                                                      '*50 ' . _imageFile_friendCount1)
                                                              if (matchOnly1 == 1) {
                                                                  SendUiMsg("Only one friend left, exit")
                                                                      FinishRun() 
                                                                      return
                                                              } else {
                                                                  SendUiMsg("Reset user location: " . (nextUser / userIncrement) + 1 . " to 1 and retry")
                                                                      nextUser := 0
                                                              }

                                                      }

                                                  if (canDelete) {
match := ImageSearch(
               &matchedX,
               &matchedY,
               getScreenXbyWindowPercentage('12%'),
               getScreenYbyWindowPercentage('70%'),
               getScreenXbyWindowPercentage('88%'),
               getScreenYbyWindowPercentage('77%'),
               '*50 ' . _imageFile_userDetailFriendNow)
           delayXLong()
           if (match == 1) {
targetX := matchedX - targetWindowX + 5
             targetY := matchedY - targetWindowY + 5
             ControlClick('X' . targetX . ' Y' . targetY, targetWindowHwnd, , 'Left', 1, 'NA', ,)
             SendUiMsg("Click unfriend from friend detail")
             _currentLogic := "D03"
             delayXLong()
           } else if (match == 0) {
failCount := failCount + 1
               SendUiMsg("####ImageSearch failed to find unfriend button from friend detail")
               _clickCloseModalButton()
           }
nextUser := 0

                                                  } else {
                                                      SendUiMsg("Current user location: " . (nextUser / userIncrement) + 1 . " Moving to next user")
                                                          nextUser += userIncrement
                                                          _currentLogic := "D01"
                                                          failCount := 0
                                                          InitLocation("FriendList")

                                                  }

                                                  SendUiMsg("Total " userDelIndex " accounts from userdel.txt processed!")
                                                      userDelIndex++

                                                      if (failCount >= 5) {
                                                          SendUiMsg("####Fail count reached, during delete") 
                                                              _currentLogic := "D01"
                                                              failCount := 0
                                                              nextUser := 0
                                                              InitLocation("FriendList")
                                                      }


                                  case "D03":
                                                  caseDescription := _currentLocale.DeletingFriendBegin
                                                      SendUiMsg("[Current] " . _currentLogic . " : " . caseDescription)
                                                      if (_thisUserDeleted == FALSE) {
match := ImageSearch(
               &matchedX,
               &matchedY,
               getScreenXbyWindowPercentage('50%'),
               getScreenYbyWindowPercentage('62%'),
               getScreenXbyWindowPercentage('98%'),
               getScreenYbyWindowPercentage('74%'),
               '*50 ' . _imageFile_removeFriendConfirm)
           if (match == 1) {
targetX := matchedX - targetWindowX + 50
             targetY := matchedY - targetWindowY + 20
             ControlClick('X' . targetX . ' Y' . targetY, targetWindowHwnd, , 'Left', 1, 'NA', ,)
             _thisUserDeleted := TRUE
             delayLong()
           }
           else if (match == 0) {
               SendUiMsg(_currentLocale.FailureDeleteFriendCall)
                   _currentLogic := "D01"
                   failCount := 0
                   SendInput "{esc}"
                   InitLocation("FriendList")
           }
                                                      }
                                                  if (_thisUserDeleted == TRUE) {
_currentLogic := "D01"
                   delayLong()
                   _clickCloseModalButton()
                   if (failCount >= 5) {
                       SendUiMsg(_currentLocale.ScreenTransitionFailure)
                           _currentLogic := "D01"
                           failCount := 0
                           SendInput "{esc}"
                           InitLocation("FriendList")
                   }
                                                  }

                              }
                      }
}

getScreenXbyWindowPercentage(somePercentage) {
    if targetWindowWidth = false {
        MsgBox _currentLocale.TargetWindowNotSet
            return
    }
replacedPercentage := StrReplace(somePercentage, "%")
                        if IsNumber(replacedPercentage) = false {
                            MsgBox _currentLocale.ValidPorcentageNotInserted
                                return
                        }
                    return Round(targetWindowX + (targetWindowWidth * replacedPercentage / 100), -1)
}

getScreenYbyWindowPercentage(somePercentage) {
    if targetWindowHeight = false {
        MsgBox _currentLocale.TargetWindowNotSet
            return
    }
replacedPercentage := StrReplace(somePercentage, "%")
                        if IsNumber(replacedPercentage) = false {
                            MsgBox _currentLocale.ValidPorcentageNotInserted
                                return
                        }
                    return Round(targetWindowY + (targetWindowHeight * replacedPercentage / 100), -1)
}

getWindowXbyWindowPercentage(somePercentage) {
    if targetWindowWidth = false {
        MsgBox _currentLocale.TargetWindowNotSet
            return
    }
replacedPercentage := StrReplace(somePercentage, "%")
                        if IsNumber(replacedPercentage) = false {
                            MsgBox _currentLocale.ValidPorcentageNotInserted
                                return
                        }
                    return Round((targetWindowWidth * replacedPercentage / 100), -1)
}

getWindowYbyWindowPercentage(somePercentage) {
    if targetWindowHeight = false {
        MsgBox _currentLocale.TargetWindowNotSet
            return
    }

replacedPercentage := StrReplace(somePercentage, "%")
                        if IsNumber(replacedPercentage) = false {
                            MsgBox _currentLocale.ValidPorcentageNotInserted
                                return
                        }
                    return Round((targetWindowHeight * replacedPercentage / 100), -1)

}

delayShort() {
    Sleep(_delayConfig)
}

delayLong() {
    Sleep(_delayConfig * 3)
}

delayXLong() {
    Sleep(_delayConfig * 10)
}

delayLoad() {
    Sleep(2000)
}

_clickCloseModalButton() {
    ControlClick(
            'X' . getWindowXbyWindowPercentage('50%') . ' Y' . getWindowYbyWindowPercentage('95%')
            , targetWindowHwnd, , 'Left', 1, 'NA', ,)
        delayXLong()
}

_clickSafeArea() {
    ControlClick(
            'X' . getWindowXbyWindowPercentage('98%') . ' Y' . getWindowYbyWindowPercentage('50%')
            , targetWindowHwnd, , 'Left', 2, 'NA', ,)
}

_getElapsedTime() {
    global _nowAccepting
        global _recentTick, _currentTick

        _currentTick := A_TickCount
        elapsedTime := _currentTick - _recentTick
        SendUiMsg(_currentLocale.TimeOnCurrentPhase . "" . MillisecToTime(elapsedTime))
        return elapsedTime
}

PhaseToggler(elapsedTime := 0) {
    global _nowAccepting
        global _recentTick, _currentTick
        global _acceptingTermConfig

        if (_nowAccepting == TRUE
                && elapsedTime > _acceptingTermConfig) {
_nowAccepting := FALSE
                   _recentTick := A_TickCount
                   SendUiMsg(_currentLocale.AcceptingEndedBeginDelete . "" . Round(_deletingTermConfig / 60000) . " mins.")
        }   
        else if (_nowAccepting == FALSE) {
_nowAccepting := TRUE
                   _recentTick := A_TickCount
                   SendUiMsg(_currentLocale.BeginAcceptPhase)
                   SendUiMsg(_currentLocale.TimeOnCurrentPhase . "" . MillisecToTime(elapsedTime))
        }
}

InitLocation(Destination := "RequestList") {
failCount := 0
               while failCount < 10 {
match := ImageSearch(
               &matchedX
               , &matchedY
               , getScreenXbyWindowPercentage('2%')
               , getScreenYbyWindowPercentage('80%')
               , getScreenXbyWindowPercentage('24%')
               , getScreenYbyWindowPercentage('90%')
               , '*100 ' . _imageFile_friendMenuButton)
           if (match == 1) {
targetX := matchedX - targetWindowX + 10
             targetY := matchedY - targetWindowY + 10
             ControlClick('X' . targetX . ' Y' . targetY, targetWindowHwnd, , 'Left', 1, 'NA', ,)
             delayXLong()
             if (Destination == "RequestList") {
                 ControlClick('X' . getWindowXbyWindowPercentage('80%') . ' Y' . getWindowYbyWindowPercentage('86%'),
                         targetWindowHwnd, , 'Left', 1, 'NA', ,)
                     delayShort()
                     return
             }
             else if (Destination == "FriendList") {
                 return
             }
           }
           else if match == 0 {
failCount := failCount + 1
               _clickCloseModalButton()
               delayLong()
           }
               }
           if (failCount >= 10) {
               SendUiMsg(_currentLocale.CantRedefineScreen)
                   return
           }
}

MillisecToTime(msec) {
secs := Floor(Mod(msec / 1000, 60))
          mins := Floor(Mod(msec / (1000 * 60), 60))
          hour := Floor(Mod(msec / (1000 * 60 * 60), 24))
          days := Floor(msec / (1000 * 60 * 60 * 24))
          return Format("{} mins {:2} segs", mins, secs)
}

SendDebugMsg(Message) {
    global recentText, oldTexts, RecentTextCtrl, OldTextCtrl
        _logRecord(Message)
        if (recentText == "") {
        }
        else {
oldTexts := recentText . (oldTexts ? "`n" . oldTexts : "")
              OldTextCtrl.Text := oldTexts
        }
    if (StrLen(oldTexts) > 2000) {
oldTexts := ""
    }

recentText := Message
                RecentTextCtrl.Text := recentText
                if (_debug == TRUE) {
                    statusGUI.Show("NA")
                }
}

SendUiMsg(Message) {
    global messageQueue
        messageQueue.Push(Message)

        i := InStr(wv.Source, "/", , -1)
        w := SubStr(wv.source, i + 1)

        if (w == "index.html") {
            _messageQueueHandler()
        }
        else {
            SetTimer(_messageQueueHandler, 100)
        }
}

_messageQueueHandler() {
    global messageQueue

        for Message in messageQueue {
            wv.ExecuteScriptAsync("addLog('" Message "')")
                wv.ExecuteScriptAsync("adjustTextAreaHeight()")
                messageQueue.RemoveAt(1)
                _logRecord(Message)
        }
    SetTimer(_messageQueueHandler, 0)
}

_logRecord(text) {
    global logfile
        FileAppend "[" . A_YYYY . "-" . A_MM . "-" . A_DD . " " . A_Hour . ":" . A_Min . ":" . A_Sec . "] " . text .
        "`n",
        logfile, "UTF-8"
}

ToggleRunUiMode() {
    wv.ExecuteScriptAsync("SwitchUIMode('" _isRunning "')")
        return
}

ToggleRunMode() {
    global _isRunning
        _isRunning := NOT _isRunning
        wv.ExecuteScriptAsync("SwitchUIMode('" _isRunning "')")
        return
}

StartRun(startLogic) {
    global _isRunning
        _isRunning := TRUE
        wv.ExecuteScriptAsync("SwitchUIMode('" TRUE "')")
        SetTimer(() => _main(startLogic), -1)
        return
}

FinishRun() {
    global _isRunning
        _isRunning := FALSE
        wv.ExecuteScriptAsync("SwitchUIMode('" FALSE "')")
        Gdip_Shutdown(pToken)  ; Shut down Gdip with the token
}

TogglePauseMode() {
    global _isPausing
        _isPausing := NOT _isPausing
        wv.ExecuteScriptAsync("SwitchPauseMode('" _isPausing "')")
        return
}

ReadUserIni() {
obj := {}
     obj.InstanceName := IniRead("Settings.ini", "UserSettings", "InstanceName")
         obj.Delay := IniRead("Settings.ini", "UserSettings", "Delay")
         obj.AcceptingTerm := IniRead("Settings.ini", "UserSettings", "AcceptingTerm")
         obj.BufferTerm := IniRead("Settings.ini", "UserSettings", "BufferTerm")
         obj.Locale := IniRead("Settings.ini", "UserLocale", "Locale")
         return obj
}

UpdateUserIni(obj) {
    IniWrite obj.InstanceName, "Settings.ini", "UserSettings", "InstanceName"
        IniWrite obj.Delay, "Settings.ini", "UserSettings", "Delay"
        IniWrite obj.AcceptingTerm, "Settings.ini", "UserSettings", "AcceptingTerm"
        IniWrite obj.BufferTerm, "Settings.ini", "UserSettings", "BufferTerm"
        IniWrite obj.Locale, "Settings.ini", "UserLocale", "Locale"
}

UpdateHtmlVersion(version) {
    wv.ExecuteScriptAsync("updateVersionText('" version "')")
}

;; ------ DictionarySet -------

ReadUserLocale(_locale) {
    _currentLocale.Translator := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "Translator")
        _currentLocale.RecommendedResolution := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "RecommendedResolution")
        _currentLocale.RecommendedEmulator := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "RecommendedEmulator")
        _currentLocale.RecommendedInstanceResolution := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "RecommendedInstanceResolution")
        _currentLocale.InicializationComplete := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InicializationComplete")
        _currentLocale.OriginalRepoLinkText := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "OriginalRepoLinkText")
        _currentLocale.AutomaticUpdate := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "AutomaticUpdate")
        _currentLocale.FileStateCheck := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FileStateCheck")
        _currentLocale.NoFileToUpdate := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "NoFileToUpdate")
        _currentLocale.UpdateInsertError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UpdateInsertError")
        _currentLocale.UpdateDownloadError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UpdateDownloadError")
        _currentLocale.DownloadGeneralError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DownloadGeneralError")
        _currentLocale.DownloadProgressError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DownloadProgressError")
        _currentLocale.FileVerificationError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FileVerificationError")
        _currentLocale.FilePackageVerificationError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FilePackageVerificationError")
        _currentLocale.UpdateVerificationError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UpdateVerificationError")
        _currentLocale.UpdateInstallError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UpdateInstallError")
        _currentLocale.UpdateGeneralError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UpdateGeneralError")
        _currentLocale.PauseButton := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "PauseButton")
        _currentLocale.ContinueButton := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ContinueButton")
        _currentLocale.EnvironmentConfig := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "EnvironmentConfig")
        _currentLocale.InstanceName := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InstanceName")
        _currentLocale.InstanceNameDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InstanceNameDesc")
        _currentLocale.DelayMs := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DelayMs")
        _currentLocale.DelayMsDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DelayMsDesc")
        _currentLocale.AcceptingTerm := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "AcceptingTerm")
        _currentLocale.AcceptingTermDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "AcceptingTermDesc")
        _currentLocale.DeletingWaitTime := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DeletingWaitTime")
        _currentLocale.DeletingWaitTimeDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DeletingWaitTimeDesc")
        _currentLocale.Language := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "Language")
        _currentLocale.LanguageDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "LanguageDesc")
        _currentLocale.SaveButton := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "SaveButton")
        _currentLocale.CancelButton := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "CancelButton")
        _currentLocale.DebugMsgDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DebugMsgDesc")
        _currentLocale.InstanceNameNotInserted := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InstanceNameNotInserted")
        _currentLocale.InstanceNameNotFound := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InstanceNameNotFound")
        _currentLocale.InstanceNameNotRunningGame := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "InstanceNameNotRunningGame")
        _currentLocale.StartFriendAddName := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "StartFriendAddName")
        _currentLocale.StartFriendAddDesc := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "StartFriendAddDesc")
        _currentLocale.ConfirmAdd := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ConfirmAdd")
        _currentLocale.PhaseChangeDeletion := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "PhaseChangeDeletion")
        _currentLocale.FriendRequestListEmpty := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FriendRequestListEmpty")
        _currentLocale.ReloadScriptTip := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ReloadScriptTip")
        _currentLocale.ReloadScriptFailure := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ReloadScriptFailure")
        _currentLocale.NoRecentActivityError := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "NoRecentActivityError")
        _currentLocale.UserScreenOpen := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserScreenOpen")
        _currentLocale.UserCancelledRequest := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserCancelledRequest")
        _currentLocale.EnteringUserProfile := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "EnteringUserProfile")
        _currentLocale.UserInspection := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserInspection")
        _currentLocale.UserInspectionFail := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserInspectionFail")
        _currentLocale.UserInspectionRefused := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserInspectionRefused")
        _currentLocale.UserReentry := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserReentry")
        _currentLocale.SolicitationProccess := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "SolicitationProccess")
        _currentLocale.ApproveFail := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ApproveFail")
        _currentLocale.NextApproval := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "NextApproval")
        _currentLocale.ErrorSolicitationNotFound := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ErrorSolicitationNotFound")
        _currentLocale.WaitingNextStep := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "WaitingNextStep")
        _currentLocale.RefusalSucceded := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "RefusalSucceded")
        _currentLocale.UserScreenFail := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "UserScreenFail")
        _currentLocale.DeletingFriendBegin := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DeletingFriendBegin")
        _currentLocale.GoToFriendDeleteMenu := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "GoToFriendDeleteMenu")
        _currentLocale.FriendListVerify := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FriendListVerify")
        _currentLocale.AllFriendsDeleted := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "AllFriendsDeleted")
        _currentLocale.ReturningToAddPhase := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ReturningToAddPhase")
        _currentLocale.CriticalFailureExit := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "CriticalFailureExit")
        _currentLocale.RedefiningScreen := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "RedefiningScreen")
        _currentLocale.ScreenFriendEntering := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ScreenFriendEntering")
        _currentLocale.FailureDeleteFriendCall := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "FailureDeleteFriendCall")
        _currentLocale.DeletingFriendsSuccess := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "DeletingFriendsSuccess")
        _currentLocale.TryingToFind := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "TryingToFind")
        _currentLocale.ScreenTransitionFailure := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ScreenTransitionFailure")
        _currentLocale.TargetWindowNotSet := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "TargetWindowNotSet")
        _currentLocale.ValidPorcentageNotInserted := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "ValidPorcentageNotInserted")
        _currentLocale.TimeOnCurrentPhase := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "TimeOnCurrentPhase")
        _currentLocale.AcceptingEndedBeginDelete := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "AcceptingEndedBeginDelete")
        _currentLocale.BeginAcceptPhase := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "BeginAcceptPhase")
        _currentLocale.CantRedefineScreen := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "CantRedefineScreen")
        _currentLocale.OperationEnd := IniRead(_localeFolderPath . "" . _locale . ".ini", "Locale", "OperationEnd")
}
