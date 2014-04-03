##############################################################################
# File Name:	ContactDataStore.rb
# Author:			chadd williams
# Date:				4/3/2014
# Class:			CS 360 Fall 2014
# Assignment:	Introduction to Ruby and Git
# Purpose:		Provide a class containing an array of ContactEntries
##############################################################################

require "ContactEntry.rb"

class ContactDataStore
		
	############################################################################
  # Function:		initialize

  # Description: initialize data in the class

  # Paramaeters: none

  # Returned:		nothing
  ############################################################################

	def initialize
		@dataArray = Array.new
		puts "initialize"
	end
	
	############################################################################
  # Function:		deleteData

  # Description: delete all ContactEntry data in the class

  # Paramaeters: none

  # Returned:		nothing
  ############################################################################
	
	def deleteData
		@dataArray = @dataArray.drop(@dataArray.length)
	end

	
	############################################################################
  # Function:		readData

  # Description: read data from the contacts file into the dataArray

  # Paramaeters: filename: the file to open

  # Returned:		nothing
  ############################################################################

	def readData(filename)
		@dataArray = Array.new
		file = File.open(filename)
		
		file.each_line do |line|
			array = line.split(/,/)
			entry = Struct::ContactEntry.new(array[0], array[1], array[2])
			@dataArray.push(entry)
		end
	
		file.close
		
	end
	
	############################################################################
  # Function:		writeData

  # Description: write data to the contacts file from the dataArray

  # Paramaeters: filename: the file to open

  # Returned:		nothing
  ############################################################################
 
	def writeData(filename = "out.csv")
		file = File.new(filename, "w")
		
		@dataArray.each do |singleEntry|
			file.puts "#{singleEntry[0]},#{singleEntry[1]},#{singleEntry[2]}"
		end
	
		file.close
		
	end
	
	def sortData
	end
	
	############################################################################
  # Function:		addContact

  # Description: add a ContactEntry to the array

  # Paramaeters: fname: the first name of the entry
  #							 lname: the last name of the entry
  #							 email: the email address of the entry

  # Returned:		nothing
  ############################################################################
 
	def addContact(fname,lname,email)
		@dataArray.push(Struct::ContactEntry.new(fname,lname,email))
	end
	
	def deleteContact
	end
	
	def searchData
	end
	
	############################################################################
  # Function:		visitEachContact

  # Description: invoke the method func on each entry in the array

  # Paramaeters: func: the method to invoke

  # Returned:		nothing
  ############################################################################

	def visitEachContact(func)
		@dataArray.each do |singleEntry|
			func.call(singleEntry)
		end
	
	end
	
	############################################################################
  # Function:		printToScreen

  # Description: print each ContactEntry to the screen

  # Paramaeters: none

  # Returned:		nothing
  ############################################################################
	
	def printToScreen
		visitEachContact(method ( :printContactEntry))
	end
		
end

