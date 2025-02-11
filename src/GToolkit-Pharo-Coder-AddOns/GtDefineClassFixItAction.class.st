Class {
	#name : #GtDefineClassFixItAction,
	#superclass : #GtAbstractDefineClassFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #accessing }
GtDefineClassFixItAction >> description [
	^ 'Create class ' , self nodeName
]

{ #category : #'as yet unclassified' }
GtDefineClassFixItAction >> formCreationElement [
	| element |
	element := GtCreationFormWidget forClass
			onAccept: [ :cls | 
				element
					enqueueTask: (BlTaskAction new action: [ sourceCoder requestStyleSourceText ]) ].
	element form newClassName: node name value asSymbol.
	^ element
]
