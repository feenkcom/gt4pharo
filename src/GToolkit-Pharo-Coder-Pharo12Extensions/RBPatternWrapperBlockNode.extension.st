Extension { #name : #RBPatternWrapperBlockNode }

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBPatternWrapperBlockNode >> children [
	<gtPharoPatch: #Pharo>
	^ super children copyWith: wrappedNode
]

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBPatternWrapperBlockNode >> gtLiteralsInto: aSet [
	wrappedNode gtLiteralsInto: aSet
]
