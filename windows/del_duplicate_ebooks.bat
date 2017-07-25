
# Purpose
Downloaded ebooks .rar or .zip files usually contain multiple formats: pdf, epub, mobi.
This batch script could be used to generate another batch script to remove all *.mobi file if there is a *.epub file with the same name, as well as *.epub files if there is *.pdf file.

# Usage
1. Open ebook folder, copy _find_dup.bat to there.
2. Open `cmd`
3. Run _find_dup.bat > _del_dup.bat
4. Check before run _del_dup.bat

# Script
Save this as **_find_dup.bat**

```batch
@echo OFF
For /F "tokens=*" %%G in ('dir /b *.mobi') do (
    if exist "%%~dpnG.epub" (
		@echo ON
        echo del "%%~dpnxG"
		@echo OFF
    )
	if exist "%%~dpnG.pdf" (
		@echo ON
        echo del "%%~dpnxG"
		@echo OFF
    )
)
For /F "tokens=*" %%G in ('dir /b *.epub') do (
	if exist "%%~dpnG.pdf" (
		@echo ON
        echo del "%%~dpnxG"
		@echo OFF
    )
)
@echo ON
```
