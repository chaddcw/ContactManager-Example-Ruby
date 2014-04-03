##############################################################################
# File Name:	main.rb
# Author:			chadd williams
# Date:				4/2/2014
# Class:			CS 360 Fall 2014
# Assignment:	Introduction to Ruby and Git
# Purpose:		A simple contact manager application (console and menu driven)
##############################################################################

require "ContactEntry.rb"
require "ContactDataStore.rb"

##############################################################################
# Function:		printMenu

# Description: print menu to the screen

# Paramaeters: none

# Returned:		none
##############################################################################

def printMenu
	
	puts "***"
	puts "1. Print to Screen"
	puts "2. Search"
	puts "3. Add Contact"
	puts "4. Delete Contact"
	puts "5. Write to file"
	puts "6. Quit"
end

##############################################################################
# Function:		getNewContact

# Description: read a new contact entry from the user

# Paramaeters: cds - the ContactDataStore to add the entry to

# Returned:		none
##############################################################################

def getNewContact(cds)
	
	print "Firstname: "
	fname = gets.chomp
	print "Lastname: "
	lname = gets.chomp
	print "Email: "
	email = gets.chomp
	
	cds.addContact(fname,lname,email)
	
end


# main()
if __FILE__ == $0
	choice = -1
	cds = ContactDataStore.new
		
	cds.readData("data/contacts.txt")
	
	until 6 == choice
		printMenu
		choice = gets.chomp.to_i
		
		if 1 == choice 
			cds.printToScreen
		elsif 3 == choice
			getNewContact(cds)
		elsif 5 == choice
			cds.writeData
		end
			
	end
	
	cds.deleteData
	
end
