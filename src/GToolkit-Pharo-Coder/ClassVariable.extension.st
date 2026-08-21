Extension { #name : #ClassVariable }

{ #category : #'*GToolkit-Pharo-Coder' }
ClassVariable >> createReferencesFilterStoreStringFor: aFilter on: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self definingClass name;
		nextPutAll: ' bindingOf: ';
		print: self name;
		nextPutAll: ') gtReferences'
]
