Extension { #name : #GlobalVariable }

{ #category : #'*GToolkit-Pharo-Coder' }
GlobalVariable >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	(self value isBehavior and: [ self name = self value name ])
		ifTrue: [
			aStream
				nextPutAll: self value name;
				nextPutAll: ' gtReferences' ]
		ifFalse: [
			aStream
				nextPutAll: '(Smalltalk globals associationAt: ';
				print: self name;
				nextPutAll: ') gtReferences' ]
]
