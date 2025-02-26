#Requires AutoHotkey v2.0
#Include .\app\Gdip_All.ahk  ; Ensure this is the v2-compatible version

; Initialize Gdip at the start of the script and store the token
pToken := Gdip_Startup()

; Define the OCR function
OCR(area, lang) {
    ; Extract coordinates from the array
    x := area[1]
    y := area[2]
    w := area[3]
    h := area[4]

    ; Capture the screen area using Gdip
    pBitmap := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
    
    ; Save the captured image to a temporary file
    Gdip_SaveBitmapToFile(pBitmap, "temp.png")
    
    ; Dispose of the bitmap to free memory
    Gdip_DisposeImage(pBitmap)
    
    ; Run Tesseract on the captured image
    RunWait "tesseract temp.png output -l " lang
    
    ; Read the OCR result from the output file
    T := FileRead("output.txt")
    
    ; Clean up temporary files
    FileDelete "temp.png"
    FileDelete "output.txt"
    
    ; Return the extracted text
    return T
}

; Example usage
; T := OCR([1708, 139, 180, 21], "eng")
T := OCR([1710, 130, 170, 20], "eng")
MsgBox "got text = " T

; Shut down Gdip at the end of the script, passing the token
Gdip_Shutdown(pToken)
