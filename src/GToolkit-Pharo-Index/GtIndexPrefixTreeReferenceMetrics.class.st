Class {
	#name : #GtIndexPrefixTreeReferenceMetrics,
	#superclass : #GtIndexPrefixTreeMetrics,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtIndexPrefixTreeReferenceMetrics >> targetDataForNode: aNode [ 
	^ aNode references
]
