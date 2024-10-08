Extension { #name : #GtExampleState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> asFilterModelItem [
	^ GtFilterModelExampleResultStateItem new resultState: self
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> color [
	"Return a color that represents given state"
	<return: #Color>
	^ Color transparent
]
