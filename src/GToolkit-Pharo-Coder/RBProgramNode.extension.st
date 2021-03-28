Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo-Coder' }
RBProgramNode >> gtASTMatches [
	^ GtSearchRBASTFilter ast: self
]
