tell application "Finder"
	if exists (selection) then
		set theItem to (selection as alias)
	else
		set theItem to (target of front window as alias)
	end if
	set thePath to POSIX path of theItem
end tell

-- Check if it's a file and get parent directory if so
tell application "System Events"
	if thePath ends with "/" then
		set folderPath to thePath
	else
		set folderPath to (do shell script "dirname " & quoted form of thePath)
	end if
end tell

-- Open in TablePlus
do shell script "open -n -b \"com.tinyapp.TablePlus\" --args " & quoted form of folderPath
