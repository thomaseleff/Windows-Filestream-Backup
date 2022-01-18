# Windows Filestream Backup
A batch script for backing-up any number of Windows directories using ROBOCOPY.

# Features
- File stream backup based on user-configuration
  - Configuration for the name of the filestream, the source directory, the destination directory and the copy options for the ROBOCOPY.
- Logging of each filestream individually to easily review the status of the backup.

# Installation
Instructions for setting-up the Windows Filestream Backup.

## Requirements
- Windows Operating System (minimum Windows 10)

  _Minimum requirements are known working versions. Any previous version may also be working, but has not been verified._

## Downloading Windows Filestream Backup
The Windows Filestream Backup consists of two components,
1. Backup_Filestream.bat
2. config.txt

Navigate to [Backup_Filestream.bat](Backup_Filestream.bat), copying the contents into a ".bat" file within your file system. Example directory below.
- File name **IS NOT** important.

   ```
   C:/Batch Scripting/Filestream Backup
   ```

Navigate to [config.txt](config.txt), copying the contents into a file named "config.txt" within the same directory as Backup_Filestream.bat.
- File name **IS** important, the file **MUST** be named config.txt.

# Usage
Configuring and running the Windows Filestream Backup.

## Configuring config.txt
config.txt contains the user-configured names of your filestreams, the source and destination directories and the ROBOCOPY copy options for each filestream. Any number of filestreams can be configured within config.txt.

To modify config.txt,
1. Open config.txt in a text editor. 
2. Modify existing rows or add new rows in or to config.txt for all filestreams you wish to backup, maintaining the comma-separated format.
3. Each row requires four parameters, "NAME", "SRC", "DST" and "PARAM" (as indicated by the header row). These parameters are order dependent and must remain within the original order. Do not modify or remove the header row. Each parameter is described below.
   - NAME: Quoted string for the user-provided name of the filestream to be used for logging.
   - SRC: Windows directory path of the filestream to backup.
   - DST: Windows directory path of the filestream copy to be produced in the backup.
   - OPTION: ROBOCOPY copy options to pass to the backup. For more information, review the "Copy options" sub-section of the official Microsoft documentation, [robocopy](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy).

## Running Windows Filestream Backup
The Windows Filestream Backup can be run manually through a Command Prompt session or scheduled through the Windows Task Scheduler to run periodically at a set cadence.

### Running Manually Through Command Prompt
It is recommended to first run the Windows Filestream Backup manually in order to verify set-up was completed successfully.

1. Navigate to the search box in the Windows Taskbar.
2. Search for "Command Prompt".
3. When results appear, open "Command Prompt"
4. When a new session window opens, run Backup_Filestream.bat. Default command below is based on the default directory and filename.

      ```
      "C:/Batch Scripting/Filestream Backup/Backup_Filestream.bat"
      ```
5. Once running, the batch script will execute each filestream backup in sequence, row-by-row, as defined in config.txt. To review the progress of each backup, review the output within the Command Prompt window. The Command Prompt window will close when the back-ups are complete.
6. To verify that the Windows Filestream Backup completed successfully, navigate to the /logs sub-folder located in the directory where Backup_Filestream.bat was saved. Default directory below. Within /logs there should be a unique ".log" file for each filestream defined in config.txt. Review each ".log" file for the status of each filestream's folders and files.
   ```
   C:/Batch Scripting/Filestream Backup/logs
   ```

### Scheduling Through Windows Task Scheduler to Run at a Cadence
Once the AutoEq Device Manager is verified to be working successfully, create a new task in the Windows Task Scheduler to automatically run the AutoEq Device Manager at log-on.

1. Navigate to the search box in the Windows Taskbar.
2. Search for "Command Prompt".
3. When results appear, open "Command Prompt"
4. When the application window appears, click "Create Task" within the "Actions" panel on the right-hand side of the window.
5. Within the "General" tab of the pop-up window, enter a "Name" for the task and select "Run only when user is logged on."
6. Within the "Triggers" tab of the pop-up window, select "New".
7. Within the "New Trigger" pop-up window, select "On a schedule" from the "Begin the task" drop-down options. Modify the "Settings" panel to select the cadence, day and time to repeat the backup.
8. Click "OK".
9. Within the "Actions" tab of the pop-up window, select "New".
10. Within the "New Action" pop-up window, enter the following into the "Program/script" field.

      ```
      "C:/Batch Scripting/Filestream Backup/Backup_Filestream.bat"
      ```
11. Click "OK".
12. Within the "Settings" tab of the pop-up, un-check the selection box next to the "Stop the task if it runs longer than" field.
13. Click "OK".
14. The newly created task should now appear within the Task Scheduler Library, and can be run manually by selecting the task, then by clicking Run within the "Actions" panel on the righ-hand side of the window.

# Attribution
Batch scripting method for returning the length of a string was sourced from the following webpage [https://ss64.com/nt/syntax-strlen.html](https://ss64.com/nt/syntax-strlen.html).
