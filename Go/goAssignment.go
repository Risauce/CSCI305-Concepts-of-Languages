
// ++++++++++++++++++++++++++++++++++++++++++++++++++++
//This just imports the required libraries. 
package main 

import (
"fmt"
"bufio"
"os"
"io/ioutil"
"strings"
"strconv"
)

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
func main(){
	read := readFile()
	newData := removeNumbers(read)
	writeOut(newData)
	
}

func manualError(err error){ //We would have used this if statement several times, so we made a func for it
	if err != nil{
		panic(err)
		
	return
	}

}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Reads in the file for editing. Takes in user input on what file to read, then outputs that as string
func readFile()(readIn string){
	//Set up the reader and find out user input--------
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("What File would you like to import: ")
	userFName, _ := reader.ReadString('\n') //Read the input for which file to read
	userFName = strings.TrimSpace(userFName) 	

	//Actually read in the file------------------------
	data, err := ioutil.ReadFile(userFName) //Read the file
	
	//Check for errors and return----------------------
	manualError(err) //Check if there are errors!
	readIn = string(data)
	
	return readIn
	
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Takes in the input string and removes all numbers from it. 
func removeNumbers(input string)(fixedDoc string){
	var num string
	fixedDoc = strings.Replace(input, "0", "", -1) //Replace 0 because it doesn't want to work in for loop

	for i := 0; i < 10; i++{ //Goes through each number and removes it. 
		num = strconv.Itoa(i)			
		fixedDoc = strings.Replace(fixedDoc, num, "", -1)
		
	}
	
	return fixedDoc
	
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// This writes out the string to a user defined file. 
func writeOut(out string){
	//Set up the reader (which is actually writing) and get userInput
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("File name to export: ") //User input for what file
	userOFile, _ := reader.ReadString('\n')
	userOFile = strings.TrimSpace(userOFile)
	output := []byte(out) //Make sure it is in the correct format

	err := ioutil.WriteFile(userOFile, output, 0777) //This writes out the file!
	manualError(err) //Make sure no errors. 
}

//We never opened the file so we do not have to worry about it closing. 

