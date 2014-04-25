##############################################################################
# File Name:	ContactManagerUI.rb
# Author:			chadd williams
# Date:				4/7/2014
# Class:			CS 360 Fall 2014
# Assignment:	Introduction to Ruby and Git
# Purpose:		Provide a TK UI to the contact manager
##############################################################################


# http://www.tkdocs.com/tutorial/firstexample.html
# http://rxr.whitequark.org/mri/source/ext/tk/sample/tkextlib/tile/demo.rb

require_relative "ContactDataStore.rb"

require 'tk'
require 'tkextlib/tile'


############################################################################
# Function:		putContactInGrid
#
# Description: add the given ContactEntry to the grid.  Store the 
#							TreeViewItem Id into $items
#
# Paramaeters: entry - the ContactEntry to add to the grid
#
# Returned:		nothing
############################################################################

def putContactInGrid(entry)
	$items.push $tree.insert('','end', :values=>["#{entry[0]}","#{entry[1]}","#{entry[2]}"])
end


############################################################################
# Function:		fillContactGrid
#
# Description: fill the grid with data from ContactDataStore. First empty the
#							 grid.
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################
def fillContactGrid()
		
	$items.each do |index|
		$tree.delete(index)
	end
	$items.clear
	$cds.visitEachContact( method ( :putContactInGrid))
end

############################################################################
# Function:		addContact
#
# Description: Respond to Add button click. Add the data in the entry fields
#							 to both the ContactDataStore and grid.
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################

def addContact
	$tree.insert('','end', :values => ["#{$addFN}", "#{$addLN}", "#{$addEM}"])
	$cds.addContact($addFN, $addLN, $addEM)
end

############################################################################
# Function:		delContact
#
# Description: Respond to Delete button click. Delete the selected entries
#							 in the grid.
#
#							 TODO: delete the data in the ContactDataStore as well
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################


def delContact
	item = $tree.selection
	$tree.delete($tree.selection)
	# still need to delete from cds
end

############################################################################
# Function:		searchContact
#
# Description: Respond to Search button click. Select the items in the grid
#							 that satisfy all the criteria provided by the user.
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################
def searchContact
		
	selectedItems = Array.new
	
	$items.each do |index|
		itemFN = $tree.get(index, 0)
		itemLN = $tree.get(index, 1)
		itemEM = $tree.get(index, 2)
		
		if ( itemFN == $searchFN || $searchFN.string().empty?) &&
			 ( itemLN == $searchLN || $searchLN.string().empty?) &&
			 ( itemEM == $searchEM || $searchEM.string().empty?) then
				selectedItems.push index
		end
	end
	
	$tree.selection_set selectedItems
	
end

############################################################################
# Function:		openFile
#
# Description: Respond to File | Open menu click. Read data from the file
#							 into the ContactDataStore. Fill the grid with the new data.
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################

def openFile
	filename = Tk::getOpenFile
	if ! filename.empty? then
		$cds.readData(filename)
		fillContactGrid
	end
end


############################################################################
# Function:		saveAsFile
#
# Description: Respond to File | Save menu click. Save data from the 
#							 ContactDataStore to a file.
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################

def saveAsFile
	
	filename = Tk::getSaveFile
	if ! filename.empty? then
		$cds.writeData(filename)
	end
	
end

############################################################################
# Function:		createUI
#
# Description: Build the UI for the application
#
# Paramaeters: none
#
# Returned:		nothing
############################################################################
def createUI
	
	# the root for the window
	root = TkRoot.new{title "Contact Manager" }
	root['resizable'] = false, false
	
	# don't allow the menu bar to be torn off
	TkOption.add '*tearOff', 0
	
	# create menu bar
	menubar = TkMenu.new(root)
	root['menu'] = menubar
	
	# add menu label
	file = TkMenu.new(menubar)
	menubar.add :cascade, :menu => file, :label => 'File'
	
	# fill out the menu
	file.add :command, :label => 'Open...', :command => proc{openFile}
	file.add :command, :label => 'Save As', :command => proc{saveAsFile}
	
	content = Tk::Tile::Frame.new(root) {padding "1 1 1 1"}.grid( :sticky => 'nsew')
	TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1
	
	
	# widgets for Add Contact
	addButton =	Tk::Tile::Button.new(content) {text 'Add'; command {addContact}}.
		grid( :column => 0, :row => 0, :columnspan=>2, :sticky => 'w')
	
	Tk::Tile::Label.new(content) {text 'First Name'}.grid( :column => 0, :row => 1, :sticky => 'w')
	Tk::Tile::Label.new(content) {text 'Last Name'}.grid( :column => 0, :row => 2, :sticky => 'w')
	Tk::Tile::Label.new(content) {text 'Email'}.grid( :column => 0, :row => 3, :sticky => 'w')
	
	
	$addFN = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $addFN}.grid( :column => 1, :row => 1, :sticky => 'we' )
	
	$addLN = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $addLN}.grid( :column => 1, :row => 2, :sticky => 'we' )
	
	$addEM = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $addEM}.grid( :column => 1, :row => 3, :sticky => 'we' )
	
	# widgets for Delete Contact
	deleteButton =	Tk::Tile::Button.new(content) {text 'Delete'; command {delContact}}.
		grid( :column => 2, :row => 0, :sticky => 'w')
	
	
	# widgets for Search Contact
	searchButton =	Tk::Tile::Button.new(content) {text 'Search'; command {searchContact}}.
		grid( :column => 3, :row => 0, :columnspan=>2, :sticky => 'w')
	
	Tk::Tile::Label.new(content) {text 'First Name'}.grid( :column => 3, :row => 1, :sticky => 'w')
	Tk::Tile::Label.new(content) {text 'Last Name'}.grid( :column => 3, :row => 2, :sticky => 'w')
	Tk::Tile::Label.new(content) {text 'Email'}.grid( :column => 3, :row => 3, :sticky => 'w')
	
	
	$searchFN = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $searchFN}.grid( :column => 4, :row => 1, :sticky => 'we' )
	
	$searchLN = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $searchLN}.grid( :column => 4, :row => 2, :sticky => 'we' )
	
	$searchEM = TkVariable.new; 
	Tk::Tile::Entry.new(content) {width 7; textvariable $searchEM}.grid( :column => 4, :row => 3, :sticky => 'we' )
	
	
	# widgets for display of Contacts
	$tree = Tk::Tile::Treeview.new (content) {columns 'FirstName LastName Email'}
	$tree.show('headings') # show only the listed column headings
	
	# label each column
	$tree.heading_configure( 'FirstName', :text => 'First Name')
	$tree.heading_configure( 'LastName', :text => 'Last Name')
	$tree.heading_configure( 'Email', :text => 'Email')
	
	# choose columns to display
	$tree.displaycolumns("FirstName LastName Email")
	
	$tree.grid(:column=>0, :row=>4, :sticky=>'we', :columnspan=>5)
	
	s = Tk::Tile::Scrollbar.new(content) {orient "vertical"; command proc{|*args| tree.yview(*args);} }
	$tree['yscrollcommand'] = proc{|*args| s.set(*args);}
	
	s.grid(:column => 5, :row => 4, :sticky=>'ns')
	
end


#main
if __FILE__ == $0
	
	# track the items placed in the TreeView
	$items = Array.new

	# create ContactDataStore
	$cds = ContactDataStore.new
	$cds.readData("data/contacts.txt")

	# build UI	
	createUI
	fillContactGrid
	
	# launch Tk
	Tk.mainloop
end
