Extension { #name : #OCProgramNode }

{ #category : #'*GToolkit-Pharo-Coder' }
OCProgramNode >> gtASTMatches [
	^ GtSearchRBASTFilter ast: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
OCProgramNode >> gtLiterals [
	| literals |
	literals := Set new.
	self gtLiteralsInto: literals.
	^ literals
]

{ #category : #'*GToolkit-Pharo-Coder' }
OCProgramNode >> gtLiteralsInto: aSet [
	self children do: [ :each | each gtLiteralsInto: aSet ]
]
