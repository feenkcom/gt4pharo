Class {
	#name : #GtIndexPrefixTreeImplementersMetrics,
	#superclass : #GtIndexPrefixTreeMetrics,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtIndexPrefixTreeImplementersMetrics >> targetDataForNode: aNode [ 
	^ aNode implementers
]
