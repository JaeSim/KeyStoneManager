# LiteKeyStoneManager
World of Warcraft Keystone Addon

![image](https://user-images.githubusercontent.com/36566532/113005555-8add5f00-91af-11eb-9525-f82ab5dde2f5.png)

It is simple addon for tracking keystone.

The goal of addon is
  1. collect Keystone data from characters in same BattleNet Account
  2. make help to report Keystone's you have.
  3. implement addon wihout heavy library
 
It is not updated frequently and is updated at will. (current version for 9.0.1)

History 
  21-03-30 : huge change for Shadowlands 9.0.1
  1) apply dynamic width of button.
  2) C_MythicPlus.GetWeeklyChestRewardLevel() does not work. it is replaced to that searchicg best dungeon level from play history
  3) MythicKeyStone Item ID was changed from 158923 to 180653
  4) add new map ids for shadowlands
  5) add "BackdropTemplate" inheritance attribute to use SetBackdrop
  
  19-04-18 : implement main function. make minmap button and implement chat function.
  To do List -
  1) no update issue when Keystone is updated as finish dunjeon.  


  19-04-14 : Make MainUI and Buttons. 
  To do List -
  1) make Chat function
  2) minimap button texture
  
  19-04-10 : Use db and get MythicLevel and parking level by using WOW addon API.
  To do List - 
  1) make Main UI when minimap button is clicked.
  
  19-04-07 : Get Keystone for bag and parse it as i want to.
  TO do List - 
  1) save data to addon DB.  
  2) make Main UI Frame.
  3) imeplement to getting parking Keystone Level
