Extension { #name : #RBPatternWrapperBlockNode }

{ #category : #'*GToolkit-Pharo-Coder' }
RBPatternWrapperBlockNode >> children [
	<gtPharoPatch: #Pharo>
	^ super children copyWith: wrappedNode
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBPatternWrapperBlockNode >> gtLiteralsInto: aSet [
	wrappedNode gtLiteralsInto: aSet
]
