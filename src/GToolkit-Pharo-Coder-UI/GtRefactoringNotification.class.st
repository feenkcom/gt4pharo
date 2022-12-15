Class {
	#name : #GtRefactoringNotification,
	#superclass : #Notification,
	#category : #'GToolkit-Pharo-Coder-UI-Extract method'
}

{ #category : #accessing }
GtRefactoringNotification >> defaultAction [
	^ true
]

{ #category : #accessing }
GtRefactoringNotification >> messageBlock [
	^ tag
		ifNil: [ [ :element | 
			| label |
			label := BrEditor new.
			label hMatchParent.
			label vFitContent.
			label editor text: self messageText asRopedText glamorousRegularFontAndSize.
			^ label ] ]
]
