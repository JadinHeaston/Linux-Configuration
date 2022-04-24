# Linux Configuration
This contains comprehensive instructions on how to recreate my preferred Linux environment.  
This will always be a work in progress as Linux changes, and as I change.  


# Operating System
Ubuntu 20.0.4 - Minimal install  


# Applications
- Install VS Code  
  - Found in Ubuntu Software.
- Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
  - ```sudo apt install git-all```
- Install [Material-Shell](https://github.com/material-shell/material-shell)  
  - A [small bug](https://github.com/material-shell/material-shell/issues/553) exists right now that prevents "Super + D" from functioning. The "Hide All Windows" shortcut uses "CTRL + Super + D" AND "Super + D" and needs unbound in Settings > Keyboard Shortcuts`.
- Install KeePassXC  
  - ```sudo snap install keepassxc```
  - **Requires adding Google Account via Settings > Online Accounts**
    - This is needed because it directly adds Google Drive within the File manager. 