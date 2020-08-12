# Word-Scramble

Word scramble game uses UITableVIew with refreshing specific rows in stead of whole view. I also used UIAlertController with user input rather than just showing alerts. The hard part was NSRange, swift string and closure. 

## Logic
My scramble game uses a text file “start.txt” which contains over 12000 words to work with. A random string is used as title and user is asked to guess the possible words out of it. This application checks the filters such as if the word is real, possible and original. If the word satisfies all three checks then it can be added to the table list with the help of text input embedded with UIAlertController. If any of the three checks fails then it shows the error accordingly. User can also refresh to get a new word whenever the user like.

![Screenshot 2020-08-12 at 1 18 28 PM](https://user-images.githubusercontent.com/19812569/89989244-52c7f100-dc9e-11ea-9a1f-33cea1b0fcc7.png) ![Screenshot 2020-08-12 at 1 18 13 PM](https://user-images.githubusercontent.com/19812569/89989324-6b380b80-dc9e-11ea-81c7-a6cd5099724b.png)
![Screenshot 2020-08-12 at 1 17 52 PM](https://user-images.githubusercontent.com/19812569/89989417-8e62bb00-dc9e-11ea-8a25-22f330799e38.png) ![Screenshot 2020-08-12 at 1 20 43 PM](https://user-images.githubusercontent.com/19812569/89989486-a3d7e500-dc9e-11ea-8232-40df9eb2aa3b.png)


