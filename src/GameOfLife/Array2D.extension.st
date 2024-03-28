Extension { #name : #Array2D }

{ #category : #'*GameOfLife' }
Array2D class >> fromCollection: aCollectionOfCollections [
	^ self
		rows: aCollectionOfCollections size
		columns: aCollectionOfCollections first size
		tabulate: [ :c :r | (aCollectionOfCollections at: r) at: c ]
]
