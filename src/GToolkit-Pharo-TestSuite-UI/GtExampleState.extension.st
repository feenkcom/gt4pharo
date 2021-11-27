Extension { #name : #GtExampleState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> color [
	"Return a color that represents given state"
	<return: #Color>
	^ Color transparent
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> labelWithAmountFor: anExampler [
	<return: #BlText>
	| aTotal aTotalString aTotalText |
	aTotal := self numberOfExamplesFor: anExampler.
	aTotalString := ' (', aTotal asString, (' example' asPluralBasedOn: aTotal), ')'.
	aTotalText := aTotalString asRopedText foreground: Color gray.
	^ self label asRopedText
		append: aTotalText.
]
