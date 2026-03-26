Extension { #name : #OCPatternWrapperBlockNode }

{ #category : #'*GToolkit-Pharo-Coder' }
OCPatternWrapperBlockNode >> children [
	<gtPharoPatch: #Pharo>
	^ super children copyWith: wrappedNode
]

{ #category : #'*GToolkit-Pharo-Coder' }
OCPatternWrapperBlockNode >> gtLiteralsInto: aSet [
	wrappedNode gtLiteralsInto: aSet
]
