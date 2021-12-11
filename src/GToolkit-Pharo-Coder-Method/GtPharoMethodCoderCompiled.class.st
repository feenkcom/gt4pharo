Class {
	#name : #GtPharoMethodCoderCompiled,
	#superclass : #Announcement,
	#instVars : [
		'newMethod',
		'previousMethod',
		'methodCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Events'
}

{ #category : #accessing }
GtPharoMethodCoderCompiled >> isSameMethod [
	previousMethod
		ifNil: [ ^ false ].

	^ previousMethod methodClass = newMethod methodClass
		and: [ previousMethod selector = newMethod selector ]
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> methodCoder [

	^ methodCoder
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> methodCoder: anObject [

	methodCoder := anObject
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> newMethod [

	^ newMethod
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> newMethod: anObject [

	newMethod := anObject
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> previousMethod [

	^ previousMethod
]

{ #category : #accessing }
GtPharoMethodCoderCompiled >> previousMethod: anObject [

	previousMethod := anObject
]
