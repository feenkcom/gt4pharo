Extension { #name : #RBRefactoringError }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBRefactoringError >> messageBlock [
	^ [ :element | 
	| label |
	label := BrEditor new.
	label hMatchParent.
	label vFitContent.
	label editor text: self messageText asRopedText glamorousRegularFontAndSize.
	label ]
]
