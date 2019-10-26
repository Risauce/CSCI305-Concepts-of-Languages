// ---------------------------------------------------------------
// CSCI 305: Concepts/Programming Languages
// Problem 3 GO
// Anna Jinneman
// Last Updated: October 18, 2019
// ---------------------------------------------------------------
// This program will take in and read a file. It will then read through
// the file and parse out the numbers to make the hidden message readable.
// It will then export the message to another file named by the user.
// ---------------------------------------------------------------
package main

import (
"fmt"
"bufio"
"os"
"io/ioutil"
"strings"
"strconv"
)

// ---------------------------------------------------------------
// This function just calls other functions.
// ---------------------------------------------------------------
func main(){
	fileInfo := readFile()
	newData := goodbyeNumbers(fileInfo)
	writeToFile(newData)
	
}

// ---------------------------------------------------------------
// This function takes in user input and then reads the file.
// ---------------------------------------------------------------
func readFile()(fileInfo string){
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("File name to import: ")
	fileName, _ := reader.ReadString('\n')
	fileName = strings.TrimSpace(fileName)
	//fmt.Println(fileName)

	data, err := ioutil.ReadFile(fileName)
	if err != nil{			//Prints why file cannot be read.
		whatsMyError() 
		return
	}
	fileInfo = string(data)
	//fmt.Println(fileStr) 
	//goodbyeNumbers(fileStr)
	
	return fileInfo
	
}

// ---------------------------------------------------------------
// This function will "parse" out the numbers in a string.
// ---------------------------------------------------------------
func goodbyeNumbers(input string)(newData string){
	var num string
	newData = strings.Replace(input, "0", "", -1)

	for i := 0; i < 10; i++{
		num = strconv.Itoa(i)			//Converts i from int to string.
		newData = strings.Replace(newData, num, "", -1)
		
	}
	fmt.Println("")
	fmt.Println(newData) 
	fmt.Println("")
	
	return newData
	
}

// ---------------------------------------------------------------
// This function will export the new string to a file using user input.
// ---------------------------------------------------------------
func writeToFile(out string){
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("File name to export: ")
	outFile, _ := reader.ReadString('\n')
	outFile = strings.TrimSpace(outFile)
	
	output := []byte(out)

	err := ioutil.WriteFile(outFile, output, 0777)
	if err != nil{
		//fmt.Println(err)
		whatsMyError()
		return
	}
}

func whatsMyError(){
	fmt.Println("error")

}
