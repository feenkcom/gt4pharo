Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo-Coder' }
RBProgramNode >> gtASTMatches [
	^ GtSearchRBASTFilter ast: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBProgramNode >> gtLiterals [
	| literals |
	literals := Set new.
	self gtLiteralsInto: literals.
	^ literals
]

{ #category : #'*GToolkit-Pharo-Coder' }
RBProgramNode >> gtLiteralsInto: aSet [
	self children do: [ :each | each gtLiteralsInto: aSet ]
]
