Extension { #name : #String }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
String >> gtStartOfLineWhitespaceBefore: anIndex [
	"Return the whitespace that occurs before anIndex and after an EOL character. 
	If a non-whitespace character occurs before an EOL character, then return nil."

	| char index |
	index := anIndex - 1.
	char := Character cr.
	[ index > 0
		and: [ (char := self at: index) isSeparator and: [ (String crlf includes: char) not ] ] ]
		whileTrue: [ index := index - 1 ].
	^ (index > 0 and: [ String crlf includes: char ])
		ifTrue: [ self copyFrom: index + 1 to: anIndex - 1 ]
]
