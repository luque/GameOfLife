Extension { #name : #Array2D }

{ #category : #'*GameOfLife' }
Array2D class >> fromCollection: aCollectionOfCollections [
	^ self
		rows: aCollectionOfCollections size
		columns: aCollectionOfCollections first size
		tabulate: [ :c :r | (aCollectionOfCollections at: r) at: c ]
]

{ #category : #'*GameOfLife' }
Array2D >> getCellValue: row column: column [
	"Gets the value of the specified cell"

	^ row < 1 | (row > self numberOfRows) | (column > self numberOfColumns)
		| (column < 1) ifTrue: [ 0 ] ifFalse: [ self at: row at: column ]
]

{ #category : #'*GameOfLife' }
Array2D >> isAliveAtRow: rowNumber column: columnNumber [
	^ (self getCellValue: rowNumber column: columnNumber) = 1
]

{ #category : #'*GameOfLife' }
Array2D >> numberAliveNeighborsAtRow: row column: column [
	| topLeft top topRight left right bottomLeft bottomRight bottom neighbors |
	topLeft := self getCellValue: row - 1 column: column - 1.
	top := self getCellValue: row - 1 column: column.
	left := self getCellValue: row column: column - 1.
	right := self getCellValue: row column: column + 1.
	topRight := self getCellValue: row - 1 column: column + 1.
	bottomRight := self getCellValue: row + 1 column: column + 1.
	bottom := self getCellValue: row + 1 column: column.
	bottomLeft := self getCellValue: row + 1 column: column - 1.

	neighbors := topLeft + top + left + right + topRight + bottomRight + bottom
			+ bottomLeft.
	^ neighbors
]
