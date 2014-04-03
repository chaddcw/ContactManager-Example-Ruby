##############################################################################
# File Name:	ContactEntry.rb
# Author:			chadd williams
# Date:				4/2/2014
# Class:			CS 360 Fall 2014
# Assignment:	Introduction to Ruby and Git
# Purpose:		Provide a structure to store a single entry in the contact list
##############################################################################


# declare a struct to contain a single Contact
Struct.new("ContactEntry", :fname, :lname, :email)

############################################################################
# Function:		printContactEntry

# Description: print the ContactEntry to the given file. Print to STDOUT
#							 if no file is given

# Paramaeters: entry: the ContactEntry to print
#							 file: the file to print to, default to STDOUT

# Returned:		nothing
############################################################################

def printContactEntry(entry, file = $stdout)
	file.puts "#{entry[0]} #{entry[1]} #{entry[2]}"
end

