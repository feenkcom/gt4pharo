Extension { #name : #GtFilterModelTestCaseResultStateItem }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterModelTestCaseResultStateItem class >> fromCollection: aCollection [
	^ aCollection collect: [ :eachState | self new resultState: eachState ]
]
