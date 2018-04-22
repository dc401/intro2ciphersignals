<#
The Fisher Price Kid's SIGINT/Crypto Tutorial

Script ingests a word-search from at text file copy and pasted from:
http://puzzlemaker.discoveryeducation.com/WordSearchSetupForm.asp?campaign=flyout_teachers_puzzle_wordcross

Creates a multi-line string array with the offset of 0-14 (for humans 1-15)
Provides the "coordinates" for kids to give to the receiving party to derive communication from given the
shared key, which is in this case, the word-search puzzle. The actual 'crypto' function is the method of
coordinate sharing itself with a 1:1 simple substitution. If you as a parent are a devops person or have
an older kid, consider adding encrypt/decrypt functions to the mix as part of this code for more comprehensive
illustration. 
Example: (2x+k) is the cipher to encrypt with X being the plaintext numerical equivalent A-Z (position in alphabet)
K is the key you actually give it, it could be a position indexed row/column of the word search puzzle
The decryption cipher function would be the inverse, so (x-k/2) to decode the ciphertext into plaintext.

By: Dennis Chow, dchow[AT]xtecsystems.com
April 22, 2018

Find my utility scripts at:
https://github.com/dc401

Need a predictive analytics enabled SOC?
www.scissecurity.com
#>

Clear-Host

#Grab user input of the puzzle word search that was pasted into the text file. See 'example1.txt' for format
$filePath = Read-Host "Enter the filename/path of your word search puzzle pasted in txt. e.g. c:\mypuzzle.txt"

#Load the puzzle text into an multi-index string based array and remove the spaces
$puzzleArray = @((Get-Content $filePath).Replace(" ",""))

Write-Host "This is your word search puzzle array " -ForegroundColor Green -BackgroundColor Black
$puzzleArray

#set counter so you don't infinite loop limit 100 characters
[int]$counter = 0

#do while loop so you can continue finding "coordinates" of the letters you wish to signal/encrypt
do
    {
        [string]$letterInput = Read-Host "Enter the letter A-Z you wish to find coordinates for in puzzle"

        <#iterate over the 2D string array based on the length and display positions
        Note that that "-1" returns as false, if you see this value in either row or column then the char
        doesn't exist within the word search. If explaining to your child in coordinates
        make sure that they know Row = Y, and Column = X when looking at Quadrant 1
        #>
        for($i=0; $i -lt $puzzleArray.Length; $i++) { Write-Host $puzzleArray[$i] "Row:" $i "Column:" $puzzleArray[$i].IndexOf($letterInput) }

        $counter++
    }
while ($counter -lt 100)
exit