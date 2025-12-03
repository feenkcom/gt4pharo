Class {
	#name : #GtDefineParserFixItAction,
	#superclass : #GtAbstractDefineClassFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #accessing }
GtDefineParserFixItAction >> description [
	^ 'Create SmaCC parser ' , self nodeName
]

{ #category : #'as yet unclassified' }
GtDefineParserFixItAction >> formCreationElement [
	| element |
	element := GtCreationFormWidget forParser
			onAccept: [ :cls | 
				element
					enqueueTask: (BlTaskAction new action: [ sourceCoder requestStyleSourceText ]) ].
	element form parser: node name value asString.
	^ element
]
